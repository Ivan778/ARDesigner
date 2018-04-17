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

class MainViewController: UIViewController, SelectDownloadSourceDelegate, UIDocumentPickerDelegate, RPPreviewViewControllerDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var selectModelButton: UIButton!
    @IBOutlet weak var progressIndicator: UILabel!
    @IBOutlet weak var downloadModelButton: UIButton!
    @IBOutlet weak var restartSessionButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var instructionButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var openOnce = false
    
    var objectToManage = SCNNode()
    var shouldMoveModel = false
    
    var shouldRotateOrResizeModel = false
    var axis = Axis.x
    var previousValue = 0
    
    var tableView = UITableView()
    var arrayOfModels = [String]()
    
    var isVideoRecording = false
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        configuration.planeDetection = .horizontal
        
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
        shouldRotateOrResizeModel = true
        
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
            configuration.planeDetection = .horizontal
            
            self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            
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
            PhotoAndVideoRecorder.takePhoto(sceneView: self.sceneView)
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
        }
    }
    
    @IBAction func questionButtonPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let onboard = storyBoard.instantiateViewController(withIdentifier: "onboard")
        self.present(onboard, animated: true, completion: nil)
    }
    
}
