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
        setupTableView()
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
    
    private func setupTableView(){
        
        if processedDocs.count == 0{
            
            setupEmptyState()
    
        }
            
        else{
            //Display table view
        }
        
 
    }
    
    private func setupEmptyState(){
        //Display default message
        let emptyDefaultTitle = "You don't have any analysis yet."
        let emptyDefaultSubTitle = "Get started with finWise by adding a document today!"
        
        //Create a stack view
        let defaultMessageStack = UIStackView()
        defaultMessageStack.axis = .vertical
        defaultMessageStack.alignment = .center
        defaultMessageStack.spacing = 15
        
        //Configure document image
        let emptyIconView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 80, weight: .medium)
        emptyIconView.image = UIImage(systemName: "document.badge.plus", withConfiguration: config)
        emptyIconView.tintColor = .secondaryLabel
        emptyIconView.alpha = 0.3
        defaultMessageStack.addArrangedSubview(emptyIconView)
        
        //Connfigure title label
        let emptyTitleLabel = UILabel()
        emptyTitleLabel.text = emptyDefaultTitle
        emptyTitleLabel.textAlignment = .center
        emptyTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        emptyTitleLabel.alpha = 0.8
        defaultMessageStack.addArrangedSubview(emptyTitleLabel)
        
        //Configure subtitle label
        let emptySubtitleLabel = UILabel()
        emptySubtitleLabel.text = emptyDefaultSubTitle
        emptySubtitleLabel.textAlignment = .left
        emptySubtitleLabel.textColor = .secondaryLabel
        emptySubtitleLabel.font = UIFont.systemFont(ofSize: 14)
        emptySubtitleLabel.numberOfLines = 0
        emptySubtitleLabel.alpha = 0.7
        defaultMessageStack.addArrangedSubview(emptySubtitleLabel)
       
        view.addSubview(defaultMessageStack)
        defaultMessageStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
               defaultMessageStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               defaultMessageStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               defaultMessageStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
               defaultMessageStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
           ])
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
