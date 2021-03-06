//
//  SelectDownloadSource.swift
//  ARDesigner
//
//  Created by Иван on 20.03.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import Foundation

protocol SelectDownloadSourceDelegate {
    func googleDrivePressed()
    func filesPressed()
}

class SelectDownloadSource: UIView {
    private var googleDrive: UIButton!
    private var files: UIButton!
    private var view: UIView!
    
    var delegate: SelectDownloadSourceDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        initializeView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func initializeView() {
        view = UIView()
        self.addSubview(view)
        
        view.backgroundColor = UIColor.init(red: 88/255.0, green: 40/255.0, blue: 102/255.0, alpha: 0.5)
        view.layer.cornerRadius = 10.0
        
        googleDrive = createButton(title: "Google Drive")
        googleDrive.addTarget(self, action: #selector(googleDrivePressed), for: .touchUpInside)
        view.addSubview(googleDrive)
        
        files = createButton(title: "Files")
        files.addTarget(self, action: #selector(filesPressed), for: .touchUpInside)
        view.addSubview(files)
        
        setViewConstraints()
        setGoogleDriveButtonConstraints()
        setFilesButtonConstraints()
    }
    
    private func setViewConstraints() {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.8, constant: 0)
        let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
        
        let centerX = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.addConstraints([width, height, centerX, centerY])
    }
    
    private func setGoogleDriveButtonConstraints() {
        googleDrive.translatesAutoresizingMaskIntoConstraints = false
        
        let width = NSLayoutConstraint(item: googleDrive, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.75, constant: 0)
        let height = NSLayoutConstraint(item: googleDrive, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        
        let centerX = NSLayoutConstraint(item: googleDrive, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: googleDrive, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 30)
        
        self.addConstraints([width, height, centerX, top])
    }
    
    private func setFilesButtonConstraints() {
        files.translatesAutoresizingMaskIntoConstraints = false
        
        let width = NSLayoutConstraint(item: files, attribute: .width, relatedBy: .equal, toItem: googleDrive, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: files, attribute: .height, relatedBy: .equal, toItem: googleDrive, attribute: .height, multiplier: 1, constant: 0)
        
        let centerX = NSLayoutConstraint(item: files, attribute: .centerX, relatedBy: .equal, toItem: googleDrive, attribute: .centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: files, attribute: .top, relatedBy: .equal, toItem: googleDrive, attribute: .bottom, multiplier: 1, constant: 30)
        
        self.addConstraints([width, height, centerX, top])
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 7.0
        
        return button
    }
    
    @objc private func googleDrivePressed() {
        self.removeFromSuperview()
        
        if delegate != nil {
            delegate.googleDrivePressed()
        }
    }
    
    @objc private func filesPressed() {
        self.removeFromSuperview()
        
        if delegate != nil {
            delegate.filesPressed()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
}
