//
//  MainTabBarController.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.
//

import UIKit

class MainTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .systemBackground
    
        let homeVC = HomeViewController()
        let settingsVC = SettingsViewController()
        
        //Icons

        homeVC.tabBarItem = UITabBarItem(title: "Files", image: UIImage(systemName: "folder"), tag: 0)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 1)
        
        //Wrapping each inside navigation view controller
        let homeNC = createNavigationController(for: homeVC)
        let settingsNC = createNavigationController(for: settingsVC)
        
        self.viewControllers = [homeNC, settingsNC]
    }
    
    private func createNavigationController(for rootViewController: UIViewController) -> UINavigationController{
        rootViewController.navigationItem.largeTitleDisplayMode = .always
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}

#Preview {
    MainTabBarController()
}
