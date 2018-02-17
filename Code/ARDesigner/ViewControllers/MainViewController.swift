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

class MainViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
//    var s = SphereNode()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
//        let button = UIButton(frame: CGRect(x: 10, y: 100, width: 350, height: 90))
//        button.titleLabel?.text = "pos"
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.backgroundColor = UIColor.white
//        button.addTarget(self, action: #selector(touchedButton(sender:)), for: .touchUpInside)
//        view.addSubview(button)
        
        configureLighting()
    }
    
//    @objc func touchedButton(sender: Any) {
//        let position = SCNVector3.positionFrom(matrix: (sceneView.session.currentFrame?.camera.transform)!)
//        let sphere = SphereNode(position: position)
//        sceneView.scene.rootNode.addChildNode(sphere)
//
//        print(sphere.position.distance(to: s.position) * 100)
//        s = sphere
//    }
    
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
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    // MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
