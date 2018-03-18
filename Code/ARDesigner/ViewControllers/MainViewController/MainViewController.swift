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

enum Axis {
    case x
    case y
    case z
}

class MainViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var selectModelButton: UIButton!
    
    var objectToManage = SCNNode()
    var shouldMoveModel = false
    
    var shouldRotateOrResizeModel = false
    var axis = Axis.x
    var previousValue = 0
    
    var tableView = UITableView()
    var arrayOfModels = ["1920s+TT+Truck", "Black Sofa", "Chair", "Sofa with cushions", "Table+chair", "Table+Chairs", "Toy+Crain+Truck+&+Trailer"]
    
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
            let add = (Int(sender.translation(in: self.sceneView).y) > previousValue) ? Float(constant) : Float(-constant)
            switch axis {
            case .x:
                objectToManage.eulerAngles.x += add
            case .y:
                objectToManage.eulerAngles.y += add
            case .z:
                objectToManage.eulerAngles.z += add
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
        setUpSceneView()
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        sceneView.delegate = self
        //sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    // MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func selectModelClicked(_ sender: Any) {
        tableView.isHidden = false
    }
    
}
