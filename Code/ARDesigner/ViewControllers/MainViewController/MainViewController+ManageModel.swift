//
//  MainViewController+RemoveModel.swift
//  ARDesigner
//
//  Created by Иван on 18.02.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension MainViewController {
    @objc func manageModels(withGestureRecognizer recognizer: UIGestureRecognizer) {
        if !shouldRotateOrResizeModel {
            // Taptic feedback
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            let tapLocation = recognizer.location(in: sceneView)
            
            let res = ModelManager.virtualObject(at: tapLocation, of: sceneView)
            if res.first == nil {
                return
            }
            
            // Create the alert controller
            let alertController = UIAlertController(title: "Action", message: "Choose action:", preferredStyle: .alert)
            
            let moveAction = UIAlertAction(title: "Move", style: UIAlertActionStyle.default) { UIAlertAction in
                self.objectToManage = ModelManager.parentNode(node: (res.first?.node)!)
                self.shouldMoveModel = true
            }
            
            let removeAction = UIAlertAction(title: "Remove", style: UIAlertActionStyle.default) { UIAlertAction in
                let object = ModelManager.parentNode(node: (res.first?.node)!)
                object.removeFromParentNode()
            }
            
            let rotateX = UIAlertAction(title: "Rotate X", style: UIAlertActionStyle.default) { UIAlertAction in
                self.objectToManage = ModelManager.parentNode(node: (res.first?.node)!)
                self.shouldRotateOrResizeModel = true
                self.axis = .x
                self.addDoneButton()
            }
            
            let rotateY = UIAlertAction(title: "Rotate Y", style: UIAlertActionStyle.default) { UIAlertAction in
                self.objectToManage = ModelManager.parentNode(node: (res.first?.node)!)
                self.shouldRotateOrResizeModel = true
                self.axis = .y
                self.addDoneButton()
            }
            
            let rotateZ = UIAlertAction(title: "Rotate Z", style: UIAlertActionStyle.default) { UIAlertAction in
                self.objectToManage = ModelManager.parentNode(node: (res.first?.node)!)
                self.shouldRotateOrResizeModel = true
                self.axis = .z
                self.addDoneButton()
            }
            
            let changeSize = UIAlertAction(title: "Change Size", style: UIAlertActionStyle.default) { UIAlertAction in
                self.objectToManage = ModelManager.parentNode(node: (res.first?.node)!)
                self.shouldRotateOrResizeModel = true
                self.axis = .non
                self.addDoneButton()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            
            alertController.addAction(moveAction)
            alertController.addAction(removeAction)
            alertController.addAction(rotateX)
            alertController.addAction(rotateY)
            alertController.addAction(rotateZ)
            alertController.addAction(changeSize)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func addDoneButton() {
        let button = UIButton(frame: CGRect.zero)
        button.setBackgroundImage(#imageLiteral(resourceName: "Done"), for: .normal)
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(pressedDone(_:)), for: .touchUpInside)
        
        let width = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)
        let height = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)
        
        let top = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 10)
        let trail = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -10)
        
        self.view.addSubview(button)
        button.bringSubview(toFront: button)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([width, height, top, trail])
    }
    
    @objc func pressedDone(_ sender: UIButton) {
        shouldRotateOrResizeModel = false
        sender.removeFromSuperview()
    }
}
