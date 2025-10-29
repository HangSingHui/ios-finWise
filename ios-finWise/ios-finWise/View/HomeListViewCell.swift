//
//  HomeListViewCell.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 28/10/25.
//

import UIKit

class HomeListViewCell: UICollectionViewCell{
    static let identifier = "HomeListViewCell"
    
    private let previewImageView = UIImageView()
    private let identifierLabel = UILabel()
    private let pageCountLabel = UILabel()
    private let containerView = UIView()
    
    override init(frame: CGRect){
        //Container setup
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        //Setup container
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        //Add preview image view to the left hand side
        previewImageView.contentMode = .scaleAspectFit
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(previewImageView)
        
        //Add title to the image view
        identifierLabel.font = .systemFont(ofSize: 17, weight: .medium)
        identifierLabel.textColor = .label
        identifierLabel.numberOfLines = 2
        identifierLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(identifierLabel)
        
        //Add page count to image view
        pageCountLabel.font = .systemFont(ofSize: 12, weight: .light)
        pageCountLabel.textColor = .label
        pageCountLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(pageCountLabel)
        
        //Handle autolayout
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            //Align image to the left of the container
            previewImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            previewImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            previewImageView.heightAnchor.constraint(equalToConstant: 32),
            previewImageView.widthAnchor.constraint(equalToConstant: 25),
            
            identifierLabel.leadingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: 16),
            identifierLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            identifierLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            ])
        
        
    }
    
    func configure(with document: ProcessedDocument) {
        // save images to document in sequence order
        
        identifierLabel.text = document.documentIdentifier
        
        
    }

}
