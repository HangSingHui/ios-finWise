//
//  ResultListViewCell.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 28/10/25.
//

import UIKit

class ResultListViewCell: UICollectionViewCell {
    static let identifier = "ResultListViewCell"
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let severityLabel = UILabel()
    private let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Container view
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        // Icon
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .label
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconImageView)
        
        // Title
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        // Severity
        severityLabel.font = .systemFont(ofSize: 14, weight: .medium)
        severityLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(severityLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            severityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            severityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            severityLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    // Fixed configure method with optional parameters
    func configure(with title: String, icon: UIImage, severity: String?, severityColor: UIColor?) {
        titleLabel.text = title
        iconImageView.image = icon
        
        if let severity = severity, let color = severityColor {
            severityLabel.text = severity
            severityLabel.textColor = color
            severityLabel.isHidden = false
        } else {
            severityLabel.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        iconImageView.image = nil
        severityLabel.text = nil
        severityLabel.isHidden = true
    }
}
