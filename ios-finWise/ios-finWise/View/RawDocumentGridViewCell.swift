//
//  RawDocumentGridViewCell.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 25/10/25.
//

import UIKit

class RawDocumentGridViewCell: UICollectionViewCell{
    
    static let identifier = "RawDocumentGridViewCell"
    
    let documentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        return imageView
    }()
    
    let documentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(documentImageView)
        contentView.addSubview(documentLabel)
        
        NSLayoutConstraint.activate([
            // Image takes most of the space
            documentImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            documentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            documentImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            documentImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85),
            
            // Label below image
            documentLabel.topAnchor.constraint(equalTo: documentImageView.bottomAnchor, constant: 8),
            documentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            documentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            documentLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with documentImage: UIImage, label: Int){
        documentImageView.image = documentImage
        documentLabel.text = "Page \(label + 1)"
    }
}

#Preview{
    RawDocumentGridViewCell()
}
