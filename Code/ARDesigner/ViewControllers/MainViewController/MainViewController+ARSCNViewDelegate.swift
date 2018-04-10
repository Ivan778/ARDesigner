//
//  MainViewController+ARSCNViewDelegate.swift
//  ARDesigner
//
//  Created by Иван on 17.02.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension MainViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }

        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)

        plane.materials.first?.diffuse.contents = UIColor.transparentLightBlue

        let planeNode = SCNNode(geometry: plane)

        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        plane.width = 0.3
        plane.height = 0.3
        
        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print(camera.trackingState)
        
        switch camera.trackingState {
        case .notAvailable:
            self.progressIndicator.isHidden = false
            progressIndicator.text = "positioning not available"
        case .limited(let reason):
            DispatchQueue.main.async() {
                let blurView = self.view.viewWithTag(111)
                if blurView != nil {
                    self.view.bringSubview(toFront: blurView!)
                    blurView?.alpha = 1
                }
                
                self.progressIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                self.view.bringSubview(toFront: self.progressIndicator)
                self.view.bringSubview(toFront: self.activityIndicator)
            }
            
            switch reason {
            case .excessiveMotion:
                progressIndicator.text = "too fast moving"
            case .initializing:
                progressIndicator.text = "initializing"
            case .insufficientFeatures:
                progressIndicator.text = "not enough surface detail"
            case .relocalizing:
                progressIndicator.text = "relocation"
            }
            
        case .normal:
            progressIndicator.text = "success"
            
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.progressIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                
                let blurView = self.view.viewWithTag(111)
                if blurView != nil {
                    UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { blurView?.alpha = 0.0 }, completion: nil)
                }
            }
        }
    }
}
