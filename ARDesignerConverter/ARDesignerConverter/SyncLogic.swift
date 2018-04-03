//
//  SyncLogic.swift
//  ARDesignerConverter
//
//  Created by Иван on 02.04.2018.
//  Copyright © 2018 Ivan. All rights reserved.
//

import Foundation
import Zip

class SyncLogic {
    var gotFolder: Int = 0
    
    func runCycle(urls: [URL]) {
        for url in urls {
            print(checkFolder(url: url))
        }
    }
    
    func checkFolder(url: URL) -> Bool {
        var gotDae = 0
        var modelName = ""
        
        gotFolder = 0
        var textureFolder = ""
        
        var gotTextures = 0
        var rightTexture = false
        
        var oneFile = false
        
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: url.path)
            
            if contents.contains(".DS_Store") {
                let amount = contents.count - 1
                oneFile = (amount == 1)
            } else {
                oneFile = (contents.count == 1)
            }
            
            for file in contents {
                var isDir: ObjCBool = false
                
                if file.lowercased().hasSuffix(".dae") {
                    gotDae += 1
                    modelName = file
                } else if FileManager.default.fileExists(atPath: url.appendingPathComponent(file).path, isDirectory: &isDir) {
                    if isDir.boolValue {
                        gotFolder += 1
                        textureFolder = file
                        let contents = try FileManager.default.contentsOfDirectory(atPath: url.appendingPathComponent(file).path)
                        for file in contents {
                            if (file == ".DS_Store") {
                                gotTextures += 1
                                continue
                            }
                            
                            if (file.lowercased().hasSuffix(".jpg") || file.lowercased().hasSuffix(".png") || file.lowercased().hasSuffix(".jpeg")) {
                                gotTextures += 1
                            }
                        }
                        
                        rightTexture = (contents.count == gotTextures)
                    }
                }
            }
        } catch {
            print("Error")
        }
        
        if ((gotDae == 1 && gotFolder == 1 && rightTexture) || (gotDae == 1 && gotFolder == 0 && oneFile)) {
            self.createModel(url: url, pathToModel: modelName, pathToFolderWithTextures: textureFolder)
            return true
        } else {
            print("Nope")
            return false
        }
    }
    
    func createModel(url: URL, pathToModel: String, pathToFolderWithTextures: String) {
        do {
            let folderURL = URL(fileURLWithPath: DesktopFolder.outDirectory()).appendingPathComponent(url.lastPathComponent)
            try FileManager.default.createDirectory(atPath: folderURL.path, withIntermediateDirectories: false, attributes: nil)
            
            convert("\(String(describing: (Bundle.main.resourceURL?.path)!))/scntool --convert \(url.appendingPathComponent(pathToModel).path.replacingOccurrences(of: " ", with: "\\ ")) --format c3d --output \(folderURL.appendingPathComponent(pathToModel).path.replacingOccurrences(of: " ", with: "\\ ")) --force-y-up --force-interleaved --look-for-pvrtc-image")
            
            let content = try FileManager.default.contentsOfDirectory(atPath: url.appendingPathComponent(pathToFolderWithTextures).path)
            
            if gotFolder > 0 {
                for file in content {
                    try FileManager.default.copyItem(at: url.appendingPathComponent(pathToFolderWithTextures).appendingPathComponent(file), to: folderURL.appendingPathComponent(file))
                }
            }
            
            do {
                let archivePath = try Zip.quickZipFiles([folderURL], fileName: url.lastPathComponent)
                
                let outArchiveName = URL(fileURLWithPath: DesktopFolder.outDirectory()).appendingPathComponent(archivePath.lastPathComponent).deletingPathExtension().appendingPathExtension("ARD")
                print(outArchiveName)
                try FileManager.default.moveItem(at: archivePath, to: outArchiveName)
                try FileManager.default.removeItem(at: folderURL)
            } catch {
                print("Error 1")
            }
        } catch {
            print("Error")
        }
    }
}
