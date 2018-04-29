//
//  MainViewController+ToolBox.swift
//  ARDesigner
//
//  Created by Иван on 28.04.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import Foundation
import MediaPlayer

extension MainViewController {
    func listenVolumeButton() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
            audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
        } catch {
            print("error volume buttons")
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume"{
            print("got in here")
        }
    }
    
}
