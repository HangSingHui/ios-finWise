//
//  SettingsViewController.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //TODO: Work on settings view controller
    override func viewDidLoad(){
        super.viewDidLoad( )
        title = "Settings"
        setupBackground()
    }
    
    private func setupBackground(){
        
        let gradientView = GradientView()
        gradientView.frame = view.bounds
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gradientView.setupGradient()
        view.insertSubview(gradientView, at: 0)
    }
    
}

#Preview {
    MainTabBarController()
}
