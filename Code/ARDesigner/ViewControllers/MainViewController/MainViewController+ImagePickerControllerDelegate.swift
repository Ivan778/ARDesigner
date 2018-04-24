//
//  MainViewController+UIImagePickerControllerDelegate.swift
//  ARDesigner
//
//  Created by Иван on 23.04.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import Foundation

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        picker.dismiss(animated: true, completion: nil)
        
        var width = image.size.width
        var height = image.size.height
        
        switch image.imageOrientation {
        case .up:
            print("up")
        case .down:
            print("down")
            image = image.image(withRotation: .pi)
        case .left:
            print("left")
            image = image.image(withRotation: .pi / 2)
        case .right:
            print("right")
            image = image.image(withRotation: -(.pi / 2))
        default:
            print("Other")
        }
        
        var temp = width >= height ? width : height
        while temp > 0.3 {
            width *= 0.9
            height *= 0.9
            temp *= 0.9
        }
        
        let plane = SCNPlane(width: width, height: height)
        plane.firstMaterial?.diffuse.contents = image
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = paintingPosition
        
        var orientation = planePaint.eulerAngles
        print(orientation)
        orientation.x -= .pi / 2.0
        planeNode.eulerAngles = orientation
        
        sceneView.scene.rootNode.addChildNode(planeNode)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel image picking")
    }
}
