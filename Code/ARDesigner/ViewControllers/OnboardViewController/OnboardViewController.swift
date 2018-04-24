//
//  OnboardViewController.swift
//  ARDesigner
//
//  Created by Иван on 17.04.2018.
//  Copyright © 2018 3.45. All rights reserved.
//

import Foundation
import paper_onboarding

class InstructionViewController: UIViewController {
    @IBOutlet var skipButton: UIButton!
    //Vania loh
    fileprivate let items = [
        OnboardingItemInfo(informationImage: UIImage(),
                           title: "Welcome",
                           description: "Let's explore ARDesigner and all its features",
                           pageIcon: UIImage(),
                           color: UIColor(red: 152.0 / 255.0, green: 71.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "single_click"),
                           title: "Tap",
                           description: "Add models with a single click",
                           pageIcon: UIImage(),
                           color: UIColor(red: 152.0 / 255.0, green: 111.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "long_click"),
                           title: "Tap & Hold",
                           description: "Manage models with a simple tap and hold gesture",
                           pageIcon: UIImage(),
                           color: UIColor(red: 152.0 / 255.0, green: 71.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "folder"),
                           title: "Be Creative",
                           description: "Create your own models in Google Sketchup",
                           pageIcon: UIImage(),
                           color: UIColor(red: 152.0 / 255.0, green: 111.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "drive"),
                           title: "Model Import",
                           description: "Import models from Google Drive or AirDrop",
                           pageIcon: UIImage(),
                           color: UIColor(red: 152.0 / 255.0, green: 71.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "photo_camera"),
                           title: "Capture Your Work",
                           description: "Take amazing photos and videos of your scenes",
                           pageIcon: UIImage(),
                           color: UIColor(red: 152.0 / 255.0, green: 111.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "instagram"),
                           title: "Be Sociable",
                           description: "Show your friends your design talents",
                           pageIcon: UIImage(),
                           color: UIColor(red: 152.0 / 255.0, green: 71.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //skipButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubview(toFront: skipButton)
    }
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
}


// MARK: Actions
extension InstructionViewController {
    @IBAction func skipButtonTapped(_: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: PaperOnboardingDelegate
extension InstructionViewController: PaperOnboardingDelegate {
    func onboardingWillTransitonToIndex(_ index: Int) {
        //skipButton.isHidden = index == 2 ? false : true
    }
    
    func onboardingDidTransitonToIndex(_: Int) {
        
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource
extension InstructionViewController: PaperOnboardingDataSource {
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingItemsCount() -> Int {
        return items.count
    }
    
    func onboardinPageItemRadius() -> CGFloat {
        return 10
    }
}


// MARK: Constants
extension InstructionViewController {
    private static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    private static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}
