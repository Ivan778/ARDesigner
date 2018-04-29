//
//  MeasurementTool.swift
//  ARDesigner
//
//  Created by Иван on 29.04.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import Foundation
import ARKit

class MeasurementTool {
    var firstNode: SphereNode? = nil
    var secondNode: SphereNode? = nil
    
    func getLength() -> CGFloat {
        if (firstNode != nil && secondNode != nil) {
            return (firstNode?.position.distance(to: (secondNode?.position)!))!
        }
        return -1.0
    }
    
    func centerPosition() -> SCNVector3 {
        var x: Float = -1.0
        var y: Float = -1.0
        var z: Float = -1.0
        
        let length = getLength()
        if length != -1.0 {
            let f = firstNode!
            let s = secondNode!
            
            x = getCoordinate(c1: f.position.x, c2: s.position.x)// - 0.08
            y = getCoordinate(c1: f.position.y, c2: s.position.y)// + 0.05
            z = getCoordinate(c1: f.position.z, c2: s.position.z)
        }
        
        return SCNVector3.init(x, y, z)
    }
    
    func getCoordinate(c1: Float, c2: Float) -> Float {
        if c1 > c2 {
            return c1 - (c1 - c2) / 2
        } else {
            return c2 - (c2 - c1) / 2
        }
    }
}
