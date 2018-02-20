//
//  DirectoryManager.swift
//  ARDesigner
//
//  Created by Eugene on 20.02.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import Foundation

class DirectoryManager {
    
    class func checkAvailabilityOftheFolder(){
        let dirPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsURL = dirPaths[0].path
        print(docsURL)
        var found = false
        do {
            let filelist = try FileManager.default.contentsOfDirectory(atPath: docsURL)
            for filename in filelist {
                if (filename == "models") {
                    found = true
                }
            }
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        if !found {
            copyDocuments()
        }
    }
    
    class func copyFiles(pathFromBundle: String, pathDestDocs: String){
        let fileManagerIs = FileManager.default
        do {
            let filelist = try fileManagerIs.contentsOfDirectory(atPath: pathFromBundle)
            try? fileManagerIs.copyItem(atPath: pathFromBundle, toPath: pathDestDocs)
            
            for filename in filelist {
                try? fileManagerIs.copyItem(atPath: "\(pathFromBundle)/\(filename)", toPath: "\(pathDestDocs)/\(filename)")
            }
        } catch {
            print("\nError \(error)\n")
        }
    }
    
    class func copyDocuments() {
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        let docsURL = dirPaths[0]
        
        let folderPath = Bundle.main.resourceURL!.appendingPathComponent("models").path
        print(folderPath)
        let docsFolder = docsURL.appendingPathComponent("models").path
        copyFiles(pathFromBundle: folderPath, pathDestDocs: docsFolder)
    }
}
