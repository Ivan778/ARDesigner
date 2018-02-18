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
    @objc func removeModelFromScene(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        let tapLocation = recognizer.location(in: sceneView)
        
        let res = ModelManager.virtualObject(at: tapLocation, of: sceneView)
        if res.first == nil {
            return
        }
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Remove model", message: "Would You like to remove the model?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { UIAlertAction in
            let object = ModelManager.parentNode(node: (res.first?.node)!)
            object.removeFromParentNode()
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
