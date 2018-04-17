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
        if !shouldRotateOrResizeModel && !isVideoRecording {
            let tapLocation = recognizer.location(in: sceneView)
            let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
            
            guard let hitTestResult = hitTestResults.first else { return }
            let translation = hitTestResult.worldTransform.translation
            let x = translation.x
            let y = translation.y
            let z = translation.z
            
            if shouldMoveModel == false {
                let modelPath = UserDefaults.standard.string(forKey: "currentModelPath")
                if modelPath == "" {
                    let alert = UIAlertController(title: "Select model", message: "No model was selected. Press add model.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { UIAlertAction in
                        alert.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
                let url = URL(fileURLWithPath: modelPath!)
                var shipNode = SCNNode()
                
                do {
                    let shipScene = try SCNScene(url: url, options: nil)
                    shipNode = shipScene.rootNode.childNode(withName: (shipScene.rootNode.childNodes[0]).name!, recursively: false)!
                } catch {
                    return
                }
                
                let array = [shipNode.boundingBox.max.x, shipNode.boundingBox.max.y, shipNode.boundingBox.max.z]
                let max = array.max()!
                var m = max
                
                while (m > 0.5) {
                    m /= 2
                }
                
                var scale: Float = 0.1
                scale = m / max
                shipNode.scale = SCNVector3(scale, scale, scale)
                
                shipNode.position = SCNVector3(x, y, z)
                sceneView.scene.rootNode.addChildNode(shipNode)
            } else {
                objectToManage.position = SCNVector3(x, objectToManage.position.y, z)
                shouldMoveModel = false
            }
            
        } else if isVideoRecording {
            PhotoAndVideoRecorder.stopRecording(target: self)
            setButtonsStatus(status: false)
            isVideoRecording = false
        }
    }
}
