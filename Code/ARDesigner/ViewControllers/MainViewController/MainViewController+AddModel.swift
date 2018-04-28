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
        if questionPressed {
            instructionButton.isHidden = false
            
            text1.isHidden = true
            text2.isHidden = true
            text3.isHidden = true
            text4.isHidden = true
            
            questionPressed = false
            
            return
        }
        if !shouldRotateOrResizeModel && !isVideoRecording && !isTakingPhoto {
            let tapLocation = recognizer.location(in: sceneView)
            let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
            
            guard let hitTestResult = hitTestResults.first else { return }
            let translation = hitTestResult.worldTransform.translation
            let x = translation.x
            let y = translation.y
            let z = translation.z
            
            let res = ModelManager.virtualObject(at: tapLocation, of: sceneView)
            if res.first != nil {
                let planeNode = ModelManager.parentNode(node: (res.first?.node)!)
                
                if planeNode.orientation.x == 0.0 {
                    print("horizontal detected")
                } else {
                    print("vertical detected")
                    
                    let alert = UIAlertController(title: "Add Image", message: "Would You like to add an image to the wall?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Open Photos", style: .default, handler: { (UIAlertAction) -> Void in
                        let picker = UIImagePickerController()
                        picker.delegate = self
                        picker.allowsEditing = false
                        picker.sourceType = .photoLibrary
                        
                        self.paintingPosition = SCNVector3(x, y, z)
                        self.planePaint = planeNode
                        
                        self.present(picker, animated: true, completion: { () -> Void in
                            alert.dismiss(animated: true, completion: nil)
                        })
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) -> Void in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            } else {
                return
            }
            
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
