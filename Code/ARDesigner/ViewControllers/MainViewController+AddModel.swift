//
//  MainViewController+AddModel.swift
//  ARDesigner
//
//  Created by Иван on 18.02.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension MainViewController {
    @objc func addModelToScene(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        if shouldMoveModel == false {
            var modelPath = UserDefaults.standard.string(forKey: "currentModelPath")
            if modelPath == nil {
                modelPath = "art.scnassets/Toy+Crain+Truck+&+Trailer/model.dae"
            }
            
            guard let shipScene = SCNScene(named: "BB/model.dae"),
                let shipNode = shipScene.rootNode.childNode(withName: (shipScene.rootNode.childNodes[0]).name!, recursively: false)
                else { return }
            
            
            let array = [shipNode.boundingBox.max.x, shipNode.boundingBox.max.y, shipNode.boundingBox.max.z]
            let max = array.max()!
            var m = max

            while (m > 0.5) {
                m /= 2
            }

            var scale: Float = 0.1
            scale = m / max
            shipNode.scale = SCNVector3(scale, scale, scale)
            //shipNode.eulerAngles.x = .pi/2

            shipNode.position = SCNVector3(x, y, z)
            sceneView.scene.rootNode.addChildNode(shipNode)
        } else {
            objectForMoving.position = SCNVector3(x, y, z)
            shouldMoveModel = false
        }
        
    }
}
