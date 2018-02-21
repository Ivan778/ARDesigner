//
//  AddModelViewController.swift
//  ARDesigner
//
//  Created by Eugene on 18.02.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import UIKit

//UITableViewDelegate, UITableViewDataSource
class AddModelViewController: UIViewController{
    
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
        
        let dirDocuments = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(dirDocuments)
    
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // Женяss
    }

    @IBAction func pressedBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddModelViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! ModelTableViewCell
        cell.modelName?.text = content[indexPath.row]
         
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullPath = /*currentDirectory! + "/" + */"art.scnassets/" + content[indexPath.row] + "/model.dae"
        UserDefaults.standard.set(fullPath, forKey: "currentModelPath")
        self.dismiss(animated: true, completion: nil)
        
//        content = try! FileManager.default.contentsOfDirectory(atPath: fullPath)
//        print("1 = ")
//        print(content)
//
//        for file in content {
//            if let isdir = isDir(atPath: fullPath + "/" + file) {
//                if isdir {
//                     print("FOLDER = " + file)
//                } else {
//                    if file.range(of: ".dae") != nil{
//                        pathToFile = fullPath + "/" + file
//                        print(".dae FILE = " + file)
//                        UserDefaults.standard.set(pathToFile, forKey: "currentModelPath")
//                        print(pathToFile)
//                        self.dismiss(animated: true, completion: nil)
//                    }
//                    print("FILE = " + file)
//
//                }
//            } else {
//                print("Error")
//            }
//        }
        
       // let extension = NSURL(fileURLWithPath: filePath).pathExtension
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
