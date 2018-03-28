//
//  AddModelViewController.swift
//  ARDesigner
//
//  Created by Eugene on 18.02.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import UIKit

//UITableViewDelegate, UITableViewDataSource
class AddModelViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var pathToFile: String = ""
    var arrayWithURL = [String]()
    var content: [String] = []
    var currentDirectory: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentDirectory == nil {
            currentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            currentDirectory = currentDirectory! + "/models"
            //print(currentDirectory)
        }
        
        do {
            content = try FileManager.default.contentsOfDirectory(atPath: currentDirectory!)
        } catch {
            content = []
        }
        
        print(content)
        
        if content.count > 0 {
            for i in 0...(content.count - 1) {
                if content[i] == ".DS_Store" {
                    content.remove(at: i)
                    break
                }
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func pressedBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension AddModelViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        
        if indexPath.row < content.count {
            (cell.viewWithTag(100) as! UILabel).text = content[indexPath.row]
        }
         
        return cell
    }
    
    // MARK: - ToDo refactor
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullPath = currentDirectory! + "/" + content[indexPath.row]
        
        content = try! FileManager.default.contentsOfDirectory(atPath: fullPath)
        print("1 = ")
        print(content)

        for file in content {
            if let isdir = isDir(atPath: fullPath + "/" + file) {
                if isdir {
                     print("FOLDER = " + file)
                } else {
                    if file.lowercased().hasSuffix("dae") || file.range(of: ".scn") != nil {
                        pathToFile = fullPath + "/" + file
                        print(".dae FILE = " + file)
                        UserDefaults.standard.set(pathToFile, forKey: "currentModelPath")
                        print(pathToFile)
                        self.dismiss(animated: true, completion: nil)
                    }
                    print("FILE = " + file)

                }
            } else {
                print("Error")
            }
        }
        
//        let extension = NSURL(fileURLWithPath: filePath).pathExtension
    }
    
    func isDir(atPath: String) -> Bool? {
        var isDirectory: ObjCBool = false
        if FileManager.default.fileExists(atPath: atPath, isDirectory: &isDirectory) {
            if isDirectory.boolValue == true {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
