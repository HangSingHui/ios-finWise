//
//  PreprocessingView.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.
//

import UIKit

protocol PreprocessingViewControlerDelegate: AnyObject{
    func didAddNewPhoto(_ photo: UIImage)
}

extension PreprocessingViewControlerDelegate {
    func didAddPhoto(_ photo: UIImage){}
}


class PreprocessingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //This will be created the moment a photo is taken - so use that to intialise this raw document object
    //Create a RawDocument object
    
    
    var pageImages: [UIImage] = []
    var rawDocument: RawDocument!
    var collectionView: UICollectionView!
    var titleLabel: UITextField!

    
    init(documentImage: UIImage){
        pageImages.append(documentImage)
        rawDocument = RawDocument(documentTitle: "New Analysis", images: pageImages)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Analysis"
        view.backgroundColor = .secondarySystemBackground
        
        //Add cancel and upload buttons
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(handleDismiss)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(handleGenerate)
        )
        
        //Configure editable text field
        setupEditableTextField()
        
        //Configure collection view
        collectionView = UICollectionView(frame:.zero, collectionViewLayout: generateLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        collectionView.register(RawDocumentGridViewCell.self, forCellWithReuseIdentifier: RawDocumentGridViewCell.identifier)
       collectionView.register(AddMoreViewCell.self, forCellWithReuseIdentifier: AddMoreViewCell.identifier)
        
        //Setup long press delete functionality
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(longPress)
        
        setupLayout()
    
    }
    

   
    private func generateLayout() -> UICollectionViewLayout{
        // Each item takes half the width (2 columns)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(220)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(220)
        )
        
        // 2 items per row
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupEditableTextField(){
        titleLabel = UITextField()
        titleLabel.backgroundColor = .secondarySystemGroupedBackground
        titleLabel.layer.cornerRadius = 12
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        titleLabel.textColor = .label
        titleLabel.placeholder = "Add title for new analysis..."

        // Subtle shadow for depth
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOpacity = 0.05
        titleLabel.layer.shadowRadius = 4
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 2)

        // Padding
        titleLabel.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        titleLabel.leftViewMode = .always
        titleLabel.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        titleLabel.rightViewMode = .always
       
    }
    
    private func setupLayout(){
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return pageImages.count + 1
    }
    
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if indexPath.item == pageImages.count {
            print("Creating AddMoreViewCell at index \(indexPath.item)")  // ⭐️ Add this
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddMoreViewCell.identifier, for: indexPath) as? AddMoreViewCell else {
                fatalError("Unable to dequeue AddMoreCell")
            }
            return cell
        }

        let item = pageImages[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RawDocumentGridViewCell.identifier, for: indexPath) as? RawDocumentGridViewCell else {
            fatalError("Unable to dequeue RawDocumentGridViewCell")
        }
        
        cell.configure(with: item, label: indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        if indexPath.item == pageImages.count {
            addMorePhotos()
        }
        else {
            print("Tapped document \(indexPath.item)")
            //To present preview modal - just pull up the photo big
        }
    }

    @objc func handleDismiss(){
        dismiss(animated: true)
    }
    
    @objc func handleGenerate(){
        
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer){
        guard gesture.state == .began else { return }
        let point = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point), indexPath.item < pageImages.count else { return }
        
        showActionMenu(for: indexPath)
        
    }
    
    private func showActionMenu(for indexPath:IndexPath){
        let alert = UIAlertController(title: "Page \(indexPath.item + 1)", message:nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title:"Delete", style: .destructive) { _ in self.deletePage(at: indexPath)})
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func deletePage(at indexPath: IndexPath){
        if indexPath.item >= pageImages.count{
            return
        }
        //Remove indexPath.item from the array and rearrange
        pageImages.remove(at: indexPath.item)
        
        collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [indexPath])
            }, completion: { _ in
                // Reload all visible cells to update their labels
                self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems.filter { $0.item < self.pageImages.count })
            })
    }
    
    
    
    private func addMorePhotos(){
        print("add more photos function tapped")
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else{
            return
        }
        
        pageImages.append(image)
        collectionView.reloadData()
    }

    
  
    
}

#Preview {
    PreprocessingViewController(documentImage: UIImage(systemName: "folder")!)
}

