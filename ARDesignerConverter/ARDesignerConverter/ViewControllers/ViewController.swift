//
//  ViewController.swift
//  ARDesignerConverter
//
//  Created by Иван on 18.03.2018.
//  Copyright © 2018 Ivan. All rights reserved.
//

import Cocoa
import Zip

class ViewController: NSViewController {
    @IBOutlet weak var convertToARDCheckBox: NSButton!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    var myGroup = DispatchGroup()
    var gotFolder = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressIndicator.isHidden = true
        progressIndicator.stopAnimation(self)
        
        
        convertToARDCheckBox.isHidden = true
    }
    
    @IBAction func selectFolderButton(_ sender: Any) {
        let dialog = NSOpenPanel();
        
        dialog.title = "Choose folder";
        dialog.showsResizeIndicator = true
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = true
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            do {
                try FileManager.default.createDirectory(atPath: DesktopFolder.outDirectory(), withIntermediateDirectories: false, attributes: nil)
            } catch {
                print("Error")
            }
            
            progressIndicator.isHidden = false
            progressIndicator.startAnimation(self)
            (sender as! NSButton).isEnabled = false
            convertToARDCheckBox.isEnabled = false
            
            myGroup = DispatchGroup()
            
            for directory in dialog.urls {
                print(checkFolder(url: directory))
            }
        }
        
        myGroup.notify(queue: DispatchQueue.main, execute: {
            DispatchQueue.main.async {
                self.progressIndicator.isHidden = true
                self.progressIndicator.stopAnimation(self)
                (sender as! NSButton).isEnabled = true
                self.convertToARDCheckBox.isEnabled = true
            }
            
            print("Done")
        })
    }
    
    func checkFolder(url: URL) -> Bool {
        var gotDae = 0
        var modelName = ""
        
        gotFolder = 0
        var textureFolder = ""
        
        var gotTextures = 0
        var rightTexture = false
        
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: url.path)
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
        
        if ((gotDae == 1 && gotFolder == 1 && rightTexture) || (gotDae == 1 && gotFolder == 0)) {
            myGroup.enter()
            DispatchQueue.global(qos: .utility).async {
                self.createModel(url: url, pathToModel: modelName, pathToFolderWithTextures: textureFolder)
            }
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
            
            DispatchQueue.main.async {
//                if self.convertToARDCheckBox.state == .off {
                    DispatchQueue.global(qos: .utility).async {
                        do {
                            let archivePath = try Zip.quickZipFiles([folderURL], fileName: url.lastPathComponent)
                            
                            let outArchiveName = URL(fileURLWithPath: DesktopFolder.outDirectory()).appendingPathComponent(archivePath.lastPathComponent).deletingPathExtension().appendingPathExtension("ARD")
                            print(outArchiveName)
                            try FileManager.default.moveItem(at: archivePath, to: outArchiveName)
                            try FileManager.default.removeItem(at: folderURL)
                            
                            self.myGroup.leave()
                        } catch {
                            print("Error 1")
                            self.myGroup.leave()
                        }
                    }
//                } else {
//                    self.myGroup.leave()
//                }
            }
        } catch {
            print("Error")
            self.myGroup.leave()
        }
    }

}

