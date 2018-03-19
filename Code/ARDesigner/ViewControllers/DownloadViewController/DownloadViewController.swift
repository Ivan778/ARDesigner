//
//  DownloadView.swift
//  SongBook
//
//  Created by Shayimpagne on 22/02/2018.
//  Copyright © 2018 Alexander Gavrilenko. All rights reserved.
//

import Foundation
import UIKit

class DownloadViewController: UIViewController {
    var navBar: UINavigationBar!
    var signInItem: UIBarButtonItem!
    var signInButton: UIButton!
    var signInView: UIView!
    var refreshButton: UIButton!
    var refreshControl: UIRefreshControl!
    var filesTableView: UITableView!
    var saveSelected: UIButton!
    var saveAll: UIButton!
    var closeButton: UIButton!
    var controlButtonsStackView: UIStackView!
    var indicator: UIActivityIndicatorView!
    var waitView: UIView!
    var backgroundIcon: UIImageView!
    
    var downFile: GDMaybeDBFile!
    var listToDownload: [GDMaybeDBFile] = []
    var lastFolder = ""
    var content: [[GDMaybeDBFile]] = [[],[]]
    var sections: [String] = ["Folders", "Files"]
    var tag = ""
    var id = ""
    
    let downloadGroup = DispatchGroup()
    let refresh = Notification.Name("refresh")
}
