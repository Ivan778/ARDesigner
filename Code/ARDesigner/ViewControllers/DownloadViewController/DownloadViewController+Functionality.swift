//
//  DownloadViewController+Functionality.swift
//  SongBook
//
//  Created by Shayimpagne on 22/02/2018.
//  Copyright © 2018 Alexander Gavrilenko. All rights reserved.
//

import Foundation

extension DownloadViewController {
    
    @objc func signInPressed() {
        print("sign in")
    }
    
    @objc func refreshPressed() {
        print("refresh")
        refreshControl.endRefreshing()
    }
    
    @objc func saveSelectedPressed() {
        print("save selected")
    }
    
    @objc func saveAllPressed() {
        print("save all")
    }
    
    @objc func closePressed() {
        UserDefaults.standard.set(lastFolder, forKey: "lastFolder")
        self.dismiss(animated: true, completion: nil)
    }
}
