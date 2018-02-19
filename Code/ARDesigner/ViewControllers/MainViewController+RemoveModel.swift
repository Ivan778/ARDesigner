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
    @objc func removeAndMoveModelFromScene(withGestureRecognizer recognizer: UIGestureRecognizer) {
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
            let object = ModelManager.parentNode(node: (res.first?.node)!)
            
        }
        
        let removeAction = UIAlertAction(title: "Remove", style: UIAlertActionStyle.default) { UIAlertAction in
            let object = ModelManager.parentNode(node: (res.first?.node)!)
            object.removeFromParentNode()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        
        alertController.addAction(moveAction)
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
}
