//
//  ViewController.swift
//  ARDesigner
//
//  Created by Иван on 06.02.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Zip
import ReplayKit

enum Axis {
    case x
    case y
    case z
    case non
    case upDown
}

class MainViewController: UIViewController, SelectDownloadSourceDelegate, UIDocumentPickerDelegate, RPPreviewViewControllerDelegate, AVAudioPlayerDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var selectModelButton: UIButton!
    @IBOutlet weak var progressIndicator: UILabel!
    @IBOutlet weak var downloadModelButton: UIButton!
    @IBOutlet weak var restartSessionButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var instructionButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var closePhotoModeButton: UIButton!
    @IBOutlet weak var hidePlanesButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Onboarding texts
    @IBOutlet weak var text1: UITextView!
    @IBOutlet weak var text2: UITextView!
    @IBOutlet weak var text3: UITextView!
    @IBOutlet weak var text4: UITextView!
    
    var openOnce = false
    
    var objectToManage = SCNNode()
    var shouldMoveModel = false
    
    var shouldRotateOrResizeModel = false
    var axis = Axis.x
    var previousValue = 0
    
    var tableView = UITableView()
    var arrayOfModels = [String]()
    
    var isVideoRecording = false
    var isTakingPhoto = false
    
    var paintingPosition = SCNVector3()
    var planePaint = SCNNode()
    
    var allPlanes = [SCNNode]()
    var isHidden = false
    
    var measurementMode = false
    var measurementTool = MeasurementTool()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listenVolumeButton()
        
        takePhotoButton.setImage(#imageLiteral(resourceName: "take_photo_black"), for: .normal)
        takePhotoButton.setImage(#imageLiteral(resourceName: "take_photo_gray"), for: .highlighted)
        
        text1.layer.cornerRadius = 5.0
        text2.layer.cornerRadius = 5.0
        text3.layer.cornerRadius = 5.0
        text4.layer.cornerRadius = 5.0
        
        selectModelButton.layer.cornerRadius = 5.0
        setTableView()
        
        addGesturesToSceneView()
        configureLighting()
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.tag = 111
            blurEffectView.alpha = 1
            
            self.view.addSubview(blurEffectView)
        }
        
        UserDefaults.standard.set("", forKey: "currentModelPath")
        
        NotificationCenter.default.addObserver(self, selector: #selector(getModel), name: Notification.Name("getModel"), object: nil)
    }
    
    @objc func getModel() {
        let alert = UIAlertController(title: "New Model", message: "New model(s) was(were) successfully added!", preferredStyle: UIAlertControllerStyle.actionSheet)
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func addGesturesToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addModelToScene(withGestureRecognizer:)))
        let longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(manageModels(withGestureRecognizer:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(rotateOrResizeModel(_:)))
        sceneView.isUserInteractionEnabled = true
        
        sceneView.addGestureRecognizer(panGesture)
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        sceneView.addGestureRecognizer(longTapGestureRecognizer)
    }
    
    @objc func rotateOrResizeModel(_ sender:UIPanGestureRecognizer) {
        if shouldRotateOrResizeModel {
            let constant: Float = 0.02
            let sign = (Int(sender.translation(in: self.sceneView).y) > previousValue) ? Float(1) : Float(-1)
            switch axis {
            case .x:
                objectToManage.eulerAngles.x += sign * constant
            case .y:
                objectToManage.eulerAngles.y += sign * constant
            case .z:
                objectToManage.eulerAngles.z += sign * constant
            case .non:
                let const: Float = 100
                objectToManage.scale.x += sign * objectToManage.scale.x / const
                objectToManage.scale.y += sign * objectToManage.scale.y / const
                objectToManage.scale.z += sign * objectToManage.scale.z / const
            case .upDown:
                objectToManage.position.y += sign * constant
            }
        }
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !openOnce {
            setUpSceneView()
            openOnce = true
        }
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        sceneView.session.run(configuration)
        sceneView.delegate = self
    }
    
    // MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        //sceneView.session.pause()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func selectModelClicked(_ sender: Any) {
//        tableView.isHidden = false
        
    }
    
    // MARK: - download button click
    @IBAction func downloadButtonPressed(_ sender: Any) {
        //shouldRotateOrResizeModel = true
        
        let selectDS = SelectDownloadSource()
        selectDS.delegate = self
        self.view.addSubview(selectDS)
        
        selectDS.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: selectDS, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: selectDS, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        let lead = NSLayoutConstraint(item: selectDS, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let trail = NSLayoutConstraint(item: selectDS, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        self.view.addConstraints([top, bottom, lead, trail])
    }
    
    func googleDrivePressed() {
        shouldRotateOrResizeModel = false
        
        let googleDriveVC = GoogleDriveViewController()
        googleDriveVC.modalPresentationStyle = .fullScreen
        
        self.present(googleDriveVC, animated: true, completion: nil)
    }
    
    func filesPressed() {
        shouldRotateOrResizeModel = false
        
        let filesVC = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        filesVC.modalPresentationStyle = .fullScreen
        filesVC.allowsMultipleSelection = true
        filesVC.delegate = self
        
        self.present(filesVC, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        for file in urls {
            if file.pathExtension.lowercased() == "ard" {
                do {
                    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("models").appendingPathComponent(file.lastPathComponent)
                    try FileManager.default.copyItem(at: file, to: path.deletingPathExtension().appendingPathExtension("zip"))
                    print(DownloadViewController.extractARD(destURL: path.deletingPathExtension().appendingPathExtension("zip")))
                } catch {
                    
                }
                
            }
        }
    }
    
    // MARK: - restart session
    @IBAction func pressedRestartSessionButton(_ sender: Any) {
        let alert = UIAlertController(title: "Session restart", message: "Would You like to restart session? It will remove all models from the scene.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { UIAlertAction in
            let blurView = self.view.viewWithTag(111)
            if blurView != nil {
                self.view.bringSubview(toFront: blurView!)
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { blurView?.alpha = 1 }, completion: nil)
            }
            
            self.sceneView.session.pause()
            self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                node.removeFromParentNode()
            }
            
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = [.horizontal, .vertical]
            
            self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            
            // Reset flags
            self.openOnce = false

            self.objectToManage = SCNNode()
            self.shouldMoveModel = false

            self.shouldRotateOrResizeModel = false
            self.axis = Axis.x
            self.previousValue = 0

            self.tableView = UITableView()
            self.arrayOfModels = [String]()

            self.isVideoRecording = false
            self.isTakingPhoto = false
            self.isHidden = false

            self.paintingPosition = SCNVector3()
            
            self.planePaint = SCNNode()
            self.allPlanes = [SCNNode]()
            
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { UIAlertAction in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - camera click
    @IBAction func cameraButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Camera", message: "Select mode:", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo", style: .default, handler: {(UIAlertAction) -> Void in
            self.setButtonsStatus(status: true)
            
            self.isTakingPhoto = true
            self.takePhotoButton.isHidden = false
            self.closePhotoModeButton.isHidden = false
            
            //PhotoAndVideoRecorder.takePhoto(sceneView: self.sceneView)
        }))
        alert.addAction(UIAlertAction(title: "Video", style: .default, handler: {(UIAlertAction) -> Void in
            self.isVideoRecording = true
            self.setButtonsStatus(status: true)
            let videoRecorder = PhotoAndVideoRecorder()
            videoRecorder.videoPrepare(vc: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true)
    }
    
    func setButtonsStatus(status: Bool) {
        DispatchQueue.main.async {
            self.selectModelButton.isHidden = status
            self.downloadModelButton.isHidden = status
            self.restartSessionButton.isHidden = status
            self.cameraButton.isHidden = status
            self.instructionButton.isHidden = status
            self.hidePlanesButton.isHidden = status
        }
    }
    
    var questionPressed = false
    @IBAction func questionButtonPressed(_ sender: Any) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let onboard = storyBoard.instantiateViewController(withIdentifier: "onboard")
//        self.present(onboard, animated: true, completion: nil)
        
        if !questionPressed {
            text1.isHidden = false
            text2.isHidden = false
            text3.isHidden = false
            text4.isHidden = false
            
            questionPressed = true
            instructionButton.isHidden = true
        } else {
            text1.isHidden = true
            text2.isHidden = true
            text3.isHidden = true
            text4.isHidden = true
            
            questionPressed = false
        }
    }
    
    @IBAction func takePhotoPressed(_ sender: Any) {
        PhotoAndVideoRecorder.takePhoto(sceneView: self.sceneView)
        
        let blurView = self.view.viewWithTag(111)
        UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { blurView?.alpha = 1.0 }, completion: { (Bool) -> Void in
            UIView.animate(withDuration: 0.15 , delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { blurView?.alpha = 0.0 }, completion: nil)
        })
    }
    
    @IBAction func closePhotoModeButtonPressed(_ sender: Any) {
        if !measurementMode {
            isTakingPhoto = false
            
            setButtonsStatus(status: false)
            takePhotoButton.isHidden = true
            closePhotoModeButton.isHidden = true
        } else {
            self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                if node.name == "sphere" || node.name == "line" || node.name == "text" {
                    node.removeFromParentNode()
                }
            }
            
            measurementMode = false
            setButtonsStatus(status: false)
            closePhotoModeButton.isHidden = true
        }
        
    }
    
    @IBAction func hideUnhide(_ sender: Any) {
        if !isHidden {
            for plane in allPlanes {
                plane.isHidden = true
                //plane.geometry?.materials.first?.diffuse.contents = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
            }
            isHidden = true
            hidePlanesButton.setImage(#imageLiteral(resourceName: "unhide"), for: .normal)
        } else {
            for plane in allPlanes {
                plane.isHidden = false
                //plane.geometry?.materials.first?.diffuse.contents = UIColor.transparentLightBlue
            }
            isHidden = false
            hidePlanesButton.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
        }
    }
    
}
