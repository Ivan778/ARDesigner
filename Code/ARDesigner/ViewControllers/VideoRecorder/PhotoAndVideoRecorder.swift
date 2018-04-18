//
//  VideoRecorder.swift
//  ARDesigner
//
//  Created by Иван on 16.04.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import Foundation
import ReplayKit
import ARKit

class PhotoAndVideoRecorder {
    var alert: UIAlertController!
    var counter: Int = 3
    
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
                preview?.previewControllerDelegate = (target as! RPPreviewViewControllerDelegate)
                target.present(preview!, animated: true, completion: nil)
            })
            
            alert.addAction(editAction)
            alert.addAction(deleteAction)
            DispatchQueue.main.async {
                target.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    func photoPrepare(vc: UIViewController) {
        alert = UIAlertController(title: " ", message: "TAP ANYWHERE TO TAKE A PHOTO", preferredStyle: .alert)
        vc.present(alert, animated: true, completion: nil)
        
        counter = 3
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeAlertTitle), userInfo: nil, repeats: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.alert.dismiss(animated: true, completion: { () -> Void in
                timer.invalidate()
                PhotoAndVideoRecorder.startRecording()
            })
        })
    }
    
    func videoPrepare(vc: UIViewController) {
        alert = UIAlertController(title: " ", message: "TAP ANYWHERE TO STOP RECORDING", preferredStyle: .alert)
        vc.present(alert, animated: true, completion: nil)

        counter = 3
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeAlertTitle), userInfo: nil, repeats: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.alert.dismiss(animated: true, completion: { () -> Void in
                timer.invalidate()
                PhotoAndVideoRecorder.startRecording()
            })
        })
    }
    
    class func takePhoto(sceneView: ARSCNView) {
        var image = UIImage()
        image = sceneView.toImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    @objc func changeAlertTitle() {
        alert.title = "\(counter)"
        
        print(counter)
        counter -= 1
    }
    
}
