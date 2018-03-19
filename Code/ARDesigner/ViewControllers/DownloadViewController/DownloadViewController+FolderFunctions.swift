

import Foundation
import Zip

extension DownloadViewController {
    
    func isRootFolder(path: String) -> Bool {
        return path == ""
    }
    
    func getParentFolder(path: String) -> String {
        var parentPath = ""
        
        if !isRootFolder(path: path) {
            var array = path.components(separatedBy: "/")
            array.removeLast()
            array.removeFirst()
            for folder in array {
                parentPath += "/\(folder)"
            }
        }
        
        if parentPath.isEqualToString("/") {
            parentPath = ""
        }
        
        return parentPath
    }
    
    func getParentFolderName(path: String) -> String {
        var parentName = ""
        
        if !isRootFolder(path: path) {
            var array = path.components(separatedBy: "/")
            array.removeLast()
            array.removeFirst()
            for folder in array {
                parentName = folder
            }
        }
        
        return parentName
    }
    
    class func fileExtension(file: String) -> String {
        if file.lowercased().hasSuffix(".zip") || file.lowercased().hasSuffix(".ard") {
            return (file as NSString).pathExtension
        }
        
        return "non"
    }
    
    func getPathFiles(name: String) -> URL {
        let manager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destURL = manager.appendingPathComponent(name)
        
        return destURL
    }
    
    class func checkZip(destURL: URL) -> Bool {
        let file = FileManager.default
        let path = "\(file.urls(for: .documentDirectory, in: .userDomainMask)[0].path)/models/"
        var enumerator: FileManager.DirectoryEnumerator?
        
        do {
            let pathZip = try Zip.quickUnzipFile(destURL)
            try FileManager.default.removeItem(at: destURL)
            try FileManager.default.moveItem(at: pathZip, to: destURL)
            enumerator = file.enumerator(atPath: destURL.relativePath)
        } catch {
            print("error while unzipping")
        }
        
        while let element = enumerator?.nextObject() as? String {
            if "ard".caseInsensitiveCompare(fileExtension(file: element)) == ComparisonResult.orderedSame {
                let fileName = (element as NSString).lastPathComponent
                do {
                    if file.fileExists(atPath: path) {
                        try _ = file.replaceItemAt(NSURL.fileURL(withPath: "\(path)\(fileName)"), withItemAt: NSURL.fileURL(withPath: "\(destURL.relativePath)/\(element)"))
                    } else {
                        try file.copyItem(at: NSURL.fileURL(withPath: "\(destURL.relativePath)/\(element)"), to: NSURL.fileURL(withPath: "\(path)\(fileName)"))
                    }
                    
                } catch {
                    print("error while move element")
                    return false
                }
            } else if "zip".caseInsensitiveCompare(fileExtension(file: element)) == ComparisonResult.orderedSame {
                print(self.checkZip(destURL: NSURL.fileURL(withPath: "\(destURL.relativePath)/\(element)")))
            }
        }
        
        do {
            try FileManager.default.removeItem(at: destURL)
        } catch {
            print("can't remove item")
            return false
        }
        
        return true
    }
    
    class func extractARD(destURL: URL) -> Bool {
        let path = destURL.deletingPathExtension()
        
        do {
            let pathZip = try Zip.quickUnzipFile(destURL)
            try FileManager.default.removeItem(at: destURL)
            try FileManager.default.moveItem(at: pathZip.appendingPathComponent(pathZip.lastPathComponent), to: path)
            try FileManager.default.removeItem(at: pathZip)
        } catch {
            print("error while unzipping")
        }
        
        return true
    }
    
}
