//
//  HomeViewController.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.
//

import UIKit
import UniformTypeIdentifiers


class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate{
    
    //Dummy data
    let user = User(name: "Alex")
    
    let stack = UIStackView()
    
    
    var processedDocs: [ProcessedDocument] = []
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
                UIAction(title:"Camera", image: UIImage(systemName: "camera")){ _ in self.uploadByCamera()},
                
                UIAction(title:"Upload Docs",image: UIImage(systemName: "filemenu.and.pointer.arrow")){_ in self.uploadByFile()}
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
    
    @objc func uploadByCamera(){
        //Open up camera in iphone
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true,completion: nil)
        
        //If user exits without taking picture - we guide them back here, else we bring them to the preview page
        

    }
    
    @objc func uploadByFile(){
        //Open up file folder within iphone
        //Prepare document picker
        let supportedTypes: [UTType] = [.pdf, .text]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
        
        
        
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
