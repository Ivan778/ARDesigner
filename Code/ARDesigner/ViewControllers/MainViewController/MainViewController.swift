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

enum Axis {
    case x
    case y
    case z
    case non
}

class MainViewController: UIViewController, SelectDownloadSourceDelegate, UIDocumentPickerDelegate {
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var selectModelButton: UIButton!
    @IBOutlet weak var progressIndicator: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var openOnce = false
    
    var objectToManage = SCNNode()
    var shouldMoveModel = false
    
    var shouldRotateOrResizeModel = false
    var axis = Axis.x
    var previousValue = 0
    
    var tableView = UITableView()
    var arrayOfModels = [String]()
    
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
}
