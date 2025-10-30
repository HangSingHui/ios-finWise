//
//  HomeViewController.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.
//

import UIKit
import UniformTypeIdentifiers

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    let user = AppDelegate.shared.user

    private var collectionView: UICollectionView!
    private var emptyStack: UIStackView!
    private var titleLabel: UILabel!
    
    var imagePicker: UIImagePickerController!
    var documentPicker: UIDocumentPickerViewController!

    // Use computed property to always reflect AppDelegate.shared.savedAnalysis
    private var savedDocumentsArray: [ProcessedDocument] {
        return Array(AppDelegate.shared.savedAnalysis).sorted { $0.createdAt < $1.createdAt }
    }


    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupNavigationBarTitle()
        setupBackground()
        setupImageAndDocumentPickers()
        setupNavigationBar()
        setupCollectionView()
        setupEmptyState()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload collectionView to reflect any new saved analysis
        collectionView.reloadData()
        updateUI()
    }


    // MARK: - Navigation Bar
    private func setupNavigationBarTitle() {
        if let userName = user?.name {
            let displayName = userName.count > 10 ? String(userName.prefix(10)) + "..." : userName
            navigationItem.title = "Hello \(displayName) 👋"
        } else {
            navigationItem.title = "Hello there 👋"
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            menu: UIMenu(children: [
                UIAction(title:"Camera", image: UIImage(systemName: "camera")){ [weak self] _ in self?.uploadByCamera() },
//                UIAction(title:"Upload Docs", image: UIImage(systemName: "filemenu.and.pointer.arrow")){ [weak self] _ in self?.uploadByFile() }
            ])
        )
    }

    // MARK: - Image / Document Picker
    private func setupImageAndDocumentPickers() {
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        
        let supportedTypes: [UTType] = [.pdf, .text]
        documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        documentPicker.delegate = self
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let previewVC = PreprocessingViewController(documentImage: image)
        let navController = UINavigationController(rootViewController: previewVC)
        navController.modalPresentationStyle = .pageSheet
        if let sheet = navController.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        navController.isModalInPresentation = true
        present(navController, animated: true)
    }

    @objc func uploadByCamera() {
        present(imagePicker, animated: true)
    }
    
    @objc func uploadByFile() {
        present(documentPicker, animated: true)
    }

    // MARK: - Collection View
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: view.bounds.width - 32, height: 100)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeListViewCell.self, forCellWithReuseIdentifier: HomeListViewCell.identifier)
        
        // Add title
        titleLabel = UILabel()
        titleLabel.text = "Your Past Analysis"
        titleLabel.textColor = .gray
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedDocumentsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeListViewCell.identifier, for: indexPath) as! HomeListViewCell
        let doc = savedDocumentsArray[indexPath.item]
        cell.configure(with: doc)
        cell.delegate = self
        return cell
    }

    func refreshDocuments() {
        collectionView.reloadData()
        updateUI()
    }

    // MARK: - Empty State
    private func setupEmptyState() {
        emptyStack = UIStackView()
        emptyStack.axis = .vertical
        emptyStack.alignment = .center
        emptyStack.spacing = 15
        emptyStack.translatesAutoresizingMaskIntoConstraints = false
        
        let emptyIconView = UIImageView()
        emptyIconView.image = UIImage(systemName: "document.badge.plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 80, weight: .medium))
        emptyIconView.tintColor = .secondaryLabel
        emptyIconView.alpha = 0.3
        emptyStack.addArrangedSubview(emptyIconView)
        
        let emptyTitleLabel = UILabel()
        emptyTitleLabel.text = "You don't have any analysis yet."
        emptyTitleLabel.textAlignment = .center
        emptyTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        emptyTitleLabel.alpha = 0.8
        emptyStack.addArrangedSubview(emptyTitleLabel)
        
        let emptySubtitleLabel = UILabel()
        emptySubtitleLabel.text = "Get started with finWise by adding a document today!"
        emptySubtitleLabel.textAlignment = .center
        emptySubtitleLabel.font = UIFont.systemFont(ofSize: 14)
        emptySubtitleLabel.textColor = .secondaryLabel
        emptySubtitleLabel.numberOfLines = 0
        emptySubtitleLabel.alpha = 0.7
        emptyStack.addArrangedSubview(emptySubtitleLabel)
        
        view.addSubview(emptyStack)
        
        NSLayoutConstraint.activate([
            emptyStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            emptyStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func updateUI() {
        let hasDocs = !AppDelegate.shared.savedAnalysis.isEmpty
        collectionView.isHidden = !hasDocs
        titleLabel.isHidden = !hasDocs
        emptyStack.isHidden = hasDocs
    }

    // MARK: - Background Gradient
    private func setupBackground() {
        let gradientView = GradientView()
        gradientView.frame = view.bounds
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gradientView.setupGradient()
        view.insertSubview(gradientView, at: 0)
    }
}

// MARK: - HomeListViewCellDelegate
extension HomeViewController: HomeListViewCellDelegate {
    func homeListCellDidSelect(document: ProcessedDocument) {
        let resultVC = ResultsViewController(analysis: document)
        resultVC.hidesBottomBarWhenPushed = true
        
        // Set callback to refresh collection view immediately
        resultVC.onAnalysisSaved = { [weak self] in
            self?.collectionView.reloadData()
            self?.updateUI()
        }
        
        navigationController?.pushViewController(resultVC, animated: true)
    }

}

#Preview{
    MainTabBarController()
}
