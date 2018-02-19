//
//  ModelManager.swift
//  ARDesigner
//
//  Created by Иван on 18.02.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ModelManager {
    class func virtualObject(at point: CGPoint, of sceneView: ARSCNView) -> [SCNHitTestResult] {
        let hitTestOptions: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
        return sceneView.hitTest(point, options: hitTestOptions)
    }
    
    class func parentNode(node: SCNNode) -> SCNNode {
        if node.parent?.parent != nil {
            return parentNode(node: node.parent!)
        }
        return node
    }
    
}
