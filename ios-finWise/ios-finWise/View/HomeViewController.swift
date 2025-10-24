//
//  HomeViewController.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.
//

import UIKit

class HomeViewController: UIViewController{
    
    //Dummy data
    let user = User(name: "Alex")
    let stack = UIStackView()
    var documents: [Document] = []
    var selectMenu = UIMenu()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .always
        title = "Hello, \(user.name)"
        
        //Add plus button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            menu: UIMenu(children:[
                UIAction(title:"Camera", image: UIImage(systemName: "camera")){ _ in self.testCamera()},
                UIAction(title:"Upload Docs",image: UIImage(systemName: "filemenu.and.pointer.arrow")){_ in self.testCamera()}
            ])
        )
        
        //Explictly set
        self.tabBarItem = UITabBarItem(title: "Files", image: UIImage(systemName: "folder"), tag: 0)
        
        setupBackground()
        setupUI()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    @objc func testCamera(){
        print("test function")
    }
    
    @objc func addNewDocumentTapped(){
        //Configure UIMenu
        
    }
    
    private func setupBackground(){
        //TODO: Understand what this code means
        let gradientView = GradientView()
        gradientView.frame = view.bounds
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        gradientView.setupGradient()
        view.insertSubview(gradientView, at: 0)
        
    }
    
    private func setupUI(){
        //TODO: Add plus button, search bar, tab bar
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
    
        
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
         
        ])
    }
    
    
}

#Preview {
    MainTabBarController()
}
