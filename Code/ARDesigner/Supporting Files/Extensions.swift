//
//  Extensions.swift
//  ARDesigner
//
//  Created by Иван on 17.02.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import UIKit
import ARKit

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

extension UIColor {
    open class var transparentLightBlue: UIColor {
        return UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.4)
    }
}

extension SCNVector3 {
    func distance(to destination: SCNVector3) -> CGFloat {
        let dx = destination.x - x
        let dy = destination.y - y
        let dz = destination.z - z
        return CGFloat(sqrt(dx*dx + dy*dy + dz*dz))
    }
    
    static func positionFrom(matrix: matrix_float4x4) -> SCNVector3 {
        let column = matrix.columns.3
        return SCNVector3(column.x, column.y, column.z)
    }
}

extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
