//
//  HomeListViewCell.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 28/10/25.
//

import UIKit

// MARK: - Delegate Protocol
protocol HomeListViewCellDelegate: AnyObject {
    func homeListCellDidSelect(document: ProcessedDocument)
}

class HomeListViewCell: UICollectionViewCell {
    
    static let identifier = "HomeListViewCell"
    
    private let containerView = UIView()
    private let previewImageView = UIImageView()
    private let identifierLabel = UILabel()
    private let pageCountLabel = UILabel()
    
    weak var delegate: HomeListViewCellDelegate?
    private var currDocument: ProcessedDocument?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        styleCard()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(previewImageView)
        containerView.addSubview(identifierLabel)
        containerView.addSubview(pageCountLabel)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        identifierLabel.translatesAutoresizingMaskIntoConstraints = false
        pageCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),

            previewImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            previewImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            previewImageView.heightAnchor.constraint(equalToConstant: 36),
            previewImageView.widthAnchor.constraint(equalToConstant: 28),

            identifierLabel.leadingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: 14),
            identifierLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            identifierLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),

            pageCountLabel.leadingAnchor.constraint(equalTo: identifierLabel.leadingAnchor),
            pageCountLabel.topAnchor.constraint(equalTo: identifierLabel.bottomAnchor, constant: 4),
            pageCountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    private func styleCard() {
        containerView.backgroundColor = .systemBackground   // brighter
        containerView.layer.cornerRadius = 14

        // ✅ Add shadow to lift card from background
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.10
        containerView.layer.shadowRadius = 6
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func configure(with document: ProcessedDocument) {
        currDocument = document
        
        identifierLabel.text = document.documentIdentifier
       // pageCountLabel.text = "\(document.pages.count) pages"

       // previewImageView.image = document.pages.first ?? UIImage(systemName: "doc.text")
        previewImageView.tintColor = .label
        
        accessibilityLabel = document.documentIdentifier
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(tap)
    }
    
    @objc private func cellTapped() {
        guard let doc = currDocument else { return }
        delegate?.homeListCellDidSelect(document: doc)
    }
}
