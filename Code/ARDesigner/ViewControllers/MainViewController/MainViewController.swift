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

class MainViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    var shouldMoveModel = false
    var objectForMoving = SCNNode()
    @IBOutlet weak var selectModelButton: UIButton!
    
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
        let longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(removeAndMoveModelFromScene(withGestureRecognizer:)))
        
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        sceneView.addGestureRecognizer(longTapGestureRecognizer)
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
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
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
