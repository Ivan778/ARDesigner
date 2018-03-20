//
//  ViewController.swift
//  ARDesigner
//
//  Created by Иван on 06.02.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Zip

enum Axis {
    case x
    case y
    case z
    case non
}

class MainViewController: UIViewController, SelectDownloadSourceDelegate {
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var selectModelButton: UIButton!
    
    var openOnce = false
    
    var objectToManage = SCNNode()
    var shouldMoveModel = false
    
    var shouldRotateOrResizeModel = false
    var axis = Axis.x
    var previousValue = 0
    
    var tableView = UITableView()
    var arrayOfModels = [String]()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectModelButton.layer.cornerRadius = 5.0
        setTableView()
        
        addGesturesToSceneView()
        configureLighting()
    }
    
    func addGesturesToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addModelToScene(withGestureRecognizer:)))
        let longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(manageModels(withGestureRecognizer:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(rotateOrResizeModel(_:)))
        sceneView.isUserInteractionEnabled = true
        
        sceneView.addGestureRecognizer(panGesture)
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        sceneView.addGestureRecognizer(longTapGestureRecognizer)
    }
    
    @objc func rotateOrResizeModel(_ sender:UIPanGestureRecognizer) {
        if shouldRotateOrResizeModel {
            let constant: Float = 0.02
            let sign = (Int(sender.translation(in: self.sceneView).y) > previousValue) ? Float(1) : Float(-1)
            switch axis {
            case .x:
                objectToManage.eulerAngles.x += sign * constant
            case .y:
                objectToManage.eulerAngles.y += sign * constant
            case .z:
                objectToManage.eulerAngles.z += sign * constant
            case .non:
                let const: Float = 100
                objectToManage.scale.x += sign * objectToManage.scale.x / const
                objectToManage.scale.y += sign * objectToManage.scale.y / const
                objectToManage.scale.z += sign * objectToManage.scale.z / const
            }
            
        }
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !openOnce {
            setUpSceneView()
            openOnce = true
        }
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        sceneView.delegate = self
    }
    
    // MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        //sceneView.session.pause()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func selectModelClicked(_ sender: Any) {
//        tableView.isHidden = false
        
    }
    
    // MARK: - download button click
    @IBAction func downloadButtonPressed(_ sender: Any) {
        shouldRotateOrResizeModel = true
        
        let selectDS = SelectDownloadSource()
        selectDS.delegate = self
        self.view.addSubview(selectDS)
        
        selectDS.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint(item: selectDS, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.8, constant: 0)
        let height = NSLayoutConstraint(item: selectDS, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
        
        let centerX = NSLayoutConstraint(item: selectDS, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: selectDS, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraints([width, height, centerX, centerY])
    }
    
    func googleDrivePressed() {
        shouldRotateOrResizeModel = false
        
        let googleDriveVC = GoogleDriveViewController()
        googleDriveVC.modalPresentationStyle = .fullScreen
        
        self.present(googleDriveVC, animated: true, completion: nil)
    }
    
    func filesPressed() {
        shouldRotateOrResizeModel = false
        
        
    }
}
