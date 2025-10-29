//
//  RawDocumentGridViewCell.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 25/10/25.
//

import UIKit
class RawDocumentGridViewCell: UICollectionViewCell{
    
    static let identifier = "RawDocumentGridViewCell"
    
    private let cardView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        v.layer.cornerRadius = 14
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.12
        v.layer.shadowRadius = 6
        v.layer.shadowOffset = CGSize(width: 0, height: 3)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let documentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        
        contentView.addSubview(cardView)
        cardView.addSubview(documentImageView)
        cardView.addSubview(documentLabel)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            documentImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            documentImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            documentImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            documentImageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.85),
            
            documentLabel.topAnchor.constraint(equalTo: documentImageView.bottomAnchor, constant: 6),
            documentLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            documentLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            documentLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor)
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

