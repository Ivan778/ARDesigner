//
//  DownloadViewController+TableView.swift
//  SongBook
//
//  Created by Shayimpagne on 22/02/2018.
//  Copyright © 2018 Alexander Gavrilenko. All rights reserved.
//

import Foundation

extension DownloadViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.content[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = UIColor(displayP3Red: 47/255.0, green: 115/255.0, blue: 224/255.0, alpha: 0.9)
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = content[indexPath.section][indexPath.row].name
        
        if !listToDownload.contains(where: {$0.id == content[indexPath.section][indexPath.row].id}) && content[indexPath.section][indexPath.row].marked {
            content[indexPath.section][indexPath.row].setMarked(value: false)
        }
        
        cell.accessoryType = content[indexPath.section][indexPath.row].marked ? .checkmark : .none
        cell.textLabel?.textColor = content[indexPath.section][indexPath.row].isFile() && ("ard".caseInsensitiveCompare(DownloadViewController.fileExtension(file: content[indexPath.section][indexPath.row].name)) == ComparisonResult.orderedSame) ? UIColor(displayP3Red: 244/255.0, green: 89/255.0, blue: 66/255.0, alpha: 0.9) : UIColor.black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked \(indexPath.row)")
    }
}
