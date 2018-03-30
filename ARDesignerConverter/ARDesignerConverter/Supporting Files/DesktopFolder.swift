//
//  DesktopFolder.swift
//  ARDesignerConverter
//
//  Created by Иван on 18.03.2018.
//  Copyright © 2018 Ivan. All rights reserved.
//

import Foundation

class DesktopFolder {
    class func outDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        let  userDesktopDirectory = paths[0]
        
        return URL(fileURLWithPath: userDesktopDirectory).appendingPathComponent("ARConverterOut").path
    }
}
