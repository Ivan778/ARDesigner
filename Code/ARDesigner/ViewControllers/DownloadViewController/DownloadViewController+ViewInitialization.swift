//
//  DownloadViewController+ViewInitialization.swift
//  SongBook
//
//  Created by Shayimpagne on 22/02/2018.
//  Copyright © 2018 Alexander Gavrilenko. All rights reserved.
//

import Foundation

extension DownloadViewController {
    
    func initView(name: String, image: UIImage) {
        self.view.backgroundColor = UIColor(displayP3Red: 47/255.0, green: 115/255.0, blue: 224/255.0, alpha: 1)
        
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        self.view.addSubview(navBar)
        navBar.isTranslucent = false
        navBar.barTintColor = self.view.backgroundColor
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        let navItem = UINavigationItem(title: name)
        
        let closeItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: nil, action: #selector(closePressed))
        closeItem.tintColor = UIColor.white
        navItem.rightBarButtonItem = closeItem
        
        signInItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signInPressed))
        signInItem.tintColor = UIColor.white
        navItem.leftBarButtonItem = signInItem
        
        navBar.setItems([navItem], animated: false)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        
        let topBar = NSLayoutConstraint(item: navBar, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
        let centerBar = NSLayoutConstraint(item: navBar, attribute: NSLayoutAttribute.centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let widthBar = NSLayoutConstraint(item: navBar, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        
        self.view.addConstraints([topBar, centerBar, widthBar])
        
        filesTableView = UITableView()
        filesTableView.backgroundColor = UIColor.white
        filesTableView.separatorStyle = .singleLine
        filesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        filesTableView.dataSource = self
        filesTableView.delegate = self
        
        self.view.addSubview(self.filesTableView)
        
        filesTableView.translatesAutoresizingMaskIntoConstraints = false
        let leadingTable = NSLayoutConstraint(item: filesTableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingTable = NSLayoutConstraint(item: filesTableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let topTable = NSLayoutConstraint(item: filesTableView, attribute: .top, relatedBy: .equal, toItem: navBar, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomTable = NSLayoutConstraint(item: filesTableView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -44)
        
        self.view.addConstraints([leadingTable, trailingTable, topTable, bottomTable])
        
        controlButtonsStackView = UIStackView()
        controlButtonsStackView.axis = .horizontal
        controlButtonsStackView.alignment = .fill
        controlButtonsStackView.spacing = 0
        controlButtonsStackView.distribution = .fillEqually
        
        self.view.addSubview(controlButtonsStackView)
        
        controlButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        let leadingStackView = NSLayoutConstraint(item: controlButtonsStackView, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 0)
        let trailingStackView = NSLayoutConstraint(item: controlButtonsStackView, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: 0)
        let topStackView = NSLayoutConstraint(item: controlButtonsStackView, attribute: .top, relatedBy: .equal, toItem: filesTableView, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomStackView = NSLayoutConstraint(item: controlButtonsStackView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.view.addConstraints([leadingStackView, trailingStackView, topStackView, bottomStackView])
        
        saveSelected = UIButton()
        saveSelected.backgroundColor = self.view.backgroundColor
        saveSelected.addTarget(self, action: #selector(saveSelectedPressed), for: .touchUpInside)
        saveSelected.setTitle("Save Selected", for: .normal)
        
        saveAll = UIButton()
        saveAll.backgroundColor = self.view.backgroundColor
        saveAll.addTarget(self, action: #selector(saveAllPressed), for: .touchUpInside)
        saveAll.setTitle("Save All", for: .normal)
        
        controlButtonsStackView.addArrangedSubview(saveSelected)
        controlButtonsStackView.addArrangedSubview(saveAll)
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.darkGray
        refreshControl.addTarget(self, action: #selector(refreshPressed), for: UIControlEvents.valueChanged)
        filesTableView.addSubview(refreshControl)
        
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.frame = CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100)
        
        waitView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        waitView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        waitView.addSubview(indicator)
        
        signInView = UIView()
        signInView.backgroundColor = UIColor.darkGray
        
        backgroundIcon = UIImageView(image: image)
    }
    
    func topMostController() -> UIViewController {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        
        if topController != nil {
            return topController!
        }
        
        return self
    }
    
    func notAuthorized(visible: Bool) {
        if visible {
            self.view.addSubview(signInView)
            signInView.translatesAutoresizingMaskIntoConstraints = false
            
            let signTrailing = NSLayoutConstraint(item: signInView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
            let signLeading = NSLayoutConstraint(item: signInView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
            let signTop = NSLayoutConstraint(item: signInView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
            let signBottom = NSLayoutConstraint(item: signInView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
            
            self.view.addConstraints([signTrailing, signLeading, signTop, signBottom])
            
            signInButton = UIButton()
            signInButton.setTitle("Sign In", for: .normal)
            signInButton.backgroundColor = UIColor(displayP3Red: 47/255.0, green: 115/255.0, blue: 224/255.0, alpha: 1)
            signInButton.layer.cornerRadius = 15.0
            signInButton.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
            signInView.addSubview(signInButton)
            
            signInButton.translatesAutoresizingMaskIntoConstraints = false
            let centerX = NSLayoutConstraint(item: signInButton, attribute: .centerX, relatedBy: .equal, toItem: signInView, attribute: .centerX, multiplier: 1, constant: 0)
            let centerY = NSLayoutConstraint(item: signInButton, attribute: .centerY, relatedBy: .equal, toItem: signInView, attribute: .centerY, multiplier: 1, constant: 90)
            let widthSI = NSLayoutConstraint(item: signInButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
            let heightSI = NSLayoutConstraint(item: signInButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
            signInView.addConstraints([centerX, centerY, widthSI, heightSI])
            
            let cancelButton = UIButton()
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.backgroundColor = signInButton.backgroundColor
            cancelButton.layer.cornerRadius = 15.0
            cancelButton.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
            signInView.addSubview(cancelButton)
            
            cancelButton.translatesAutoresizingMaskIntoConstraints = false
            let top = NSLayoutConstraint(item: cancelButton, attribute: .top, relatedBy: .equal, toItem: signInButton, attribute: .bottom, multiplier: 1, constant: 7)
            let cancelButtonCenter = NSLayoutConstraint(item: cancelButton, attribute: .centerX, relatedBy: .equal, toItem: signInView, attribute: .centerX, multiplier: 1, constant: 0)
            let widthC = NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
            let heightC = NSLayoutConstraint(item: cancelButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
            signInView.addConstraints([top, cancelButtonCenter, widthC, heightC])
            
            signInView.backgroundColor = UIColor.white
            backgroundIcon.translatesAutoresizingMaskIntoConstraints = false
            signInView.addSubview(backgroundIcon)
            
            let iconWidth = NSLayoutConstraint(item: backgroundIcon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 180)
            let iconHeight = NSLayoutConstraint(item: backgroundIcon, attribute: .height, relatedBy: .equal, toItem: backgroundIcon, attribute: .width, multiplier: 1, constant: 0)
            let iconCenterX = NSLayoutConstraint(item: backgroundIcon, attribute: .centerX, relatedBy: .equal, toItem: signInView, attribute: .centerX, multiplier: 1, constant: 0)
            let iconBottom = NSLayoutConstraint(item: backgroundIcon, attribute: .bottom, relatedBy: .equal, toItem: signInButton, attribute: .top, multiplier: 1, constant: -70)
            
            signInView.addConstraints([iconWidth, iconHeight, iconCenterX, iconBottom])
            
        } else {
            if signInView.isDescendant(of: self.view) {
                signInView.removeFromSuperview()
            }
        }
    }
    
    func startIndicator() {
        self.indicator.startAnimating()
        self.view.addSubview(waitView)
    }
    
    func stopIndicator() {
        if waitView.isDescendant(of: self.view) {
            self.indicator.stopAnimating()
            waitView.removeFromSuperview()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
