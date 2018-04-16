//
//  VideoRecorder.swift
//  ARDesigner
//
//  Created by Иван on 16.04.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import Foundation
import ReplayKit

class VideoRecorder {
    class func startRecording() {
        guard RPScreenRecorder.shared().isAvailable else {
            print("Recording is not available at this time.")
            return
        }
        
        RPScreenRecorder.shared().isMicrophoneEnabled = true
        RPScreenRecorder.shared().startRecording { (error) in
            guard error == nil else {
                print("There was an error starting the recording.")
                return
            }
            print("Started Recording Successfully")
        }
    }
    
    class func stopRecording(target: UIViewController) {
        RPScreenRecorder.shared().stopRecording { (preview, error) in
            print("Stopped recording")
            
            guard preview != nil else {
                print("Preview controller is not available.")
                return
            }
            
            let alert = UIAlertController(title: "Recording Finished", message: "Would you like to edit or delete your recording?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction) in
                RPScreenRecorder.shared().discardRecording(handler: { () -> Void in
                    print("Recording suffessfully deleted.")
                })
            })
            
            let editAction = UIAlertAction(title: "Edit", style: .default, handler: { (action: UIAlertAction) -> Void in
                preview?.previewControllerDelegate = target as! RPPreviewViewControllerDelegate
                target.present(preview!, animated: true, completion: nil)
            })
            
            alert.addAction(editAction)
            alert.addAction(deleteAction)
            DispatchQueue.main.async {
                target.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
}
