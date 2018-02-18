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
    @IBOutlet weak var s: UISwitch!
    var planes = [SCNNode]()
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
        
        addTapGestureToSceneView()
        configureLighting()
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addShipToSceneView(withGestureRecognizer:)))
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(removeShip(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        sceneView.addGestureRecognizer(longTap)
    }
    
    func virtualObject(at point: CGPoint) -> [SCNHitTestResult] {
        let hitTestOptions: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
        return sceneView.hitTest(point, options: hitTestOptions)
    }
    
    func parentNode(node: SCNNode) -> SCNNode {
        if node.parent?.parent != nil {
            return parentNode(node: node.parent!)
        }
        return node
    }
    
    @objc func removeShip(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        let tapLocation = recognizer.location(in: sceneView)
        
        let res = virtualObject(at: tapLocation)
        if res.first == nil {
            return
        }
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Remove model", message: "Would You like to remove the model?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { UIAlertAction in
            let object = self.parentNode(node: (res.first?.node)!)
            object.removeFromParentNode()
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    var scale: Float = 0.1
    @objc func addShipToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        guard let shipScene = SCNScene(named: "art.scnassets/Toy+Crain+Truck+&+Trailer/model.dae"),
            let shipNode = shipScene.rootNode.childNode(withName: (shipScene.rootNode.childNodes[0]).name!, recursively: false)
            else { return }
        
        let array = [shipNode.boundingBox.max.x, shipNode.boundingBox.max.y, shipNode.boundingBox.max.z]
        let max = array.max()!
        var m = max
        
        while (m > 0.5) {
            m /= 2
        }
        
        scale = m / max
        shipNode.scale = SCNVector3(scale, scale, scale)
        //shipNode.eulerAngles.x = .pi/2
        
        shipNode.position = SCNVector3(x,y,z)
        sceneView.scene.rootNode.addChildNode(shipNode)
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
