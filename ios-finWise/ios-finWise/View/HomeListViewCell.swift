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
    private let iconContainerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let documentTypeLabel = UILabel()
    private let dateLabel = UILabel()
    private let chevronImageView = UIImageView()
    
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
        containerView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(documentTypeLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(chevronImageView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        iconContainerView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        documentTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Style icon container
        iconContainerView.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        iconContainerView.layer.cornerRadius = 12
        
        // Style icon
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .systemBlue
        
        // Style title
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 1
        
        // Style document type
        documentTypeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        documentTypeLabel.textColor = .secondaryLabel
        documentTypeLabel.numberOfLines = 1
        
        // Style date
        dateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        dateLabel.textColor = .tertiaryLabel
        dateLabel.numberOfLines = 1
        
        // Style chevron
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = .tertiaryLabel
        chevronImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),

            // Icon container
            iconContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconContainerView.heightAnchor.constraint(equalToConstant: 48),
            iconContainerView.widthAnchor.constraint(equalToConstant: 48),
            
            // Icon
            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 26),
            iconImageView.widthAnchor.constraint(equalToConstant: 26),

            // Title
            titleLabel.leadingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),

            // Document type
            documentTypeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            documentTypeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            documentTypeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            
            // Date
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: documentTypeLabel.bottomAnchor, constant: 2),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16),
            
            // Chevron
            chevronImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
            chevronImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func styleCard() {
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 14

        // Shadow for depth
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.08
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func configure(with document: ProcessedDocument) {
        currDocument = document
        
        // Set title
        titleLabel.text = document.documentIdentifier
        
        // Set document type
        documentTypeLabel.text = document.summary.documentType
        
        // Format and set date
        dateLabel.text = formatDate(document.createdAt)
        
        // Set icon based on document type
        let iconName = getIconName(for: document.summary.documentType)
        iconImageView.image = UIImage(systemName: iconName)
        
        // Set icon color based on document type
        let iconColor = getIconColor(for: document.summary.documentType)
        iconImageView.tintColor = iconColor
        iconContainerView.backgroundColor = iconColor.withAlphaComponent(0.1)
        
        accessibilityLabel = "\(document.documentIdentifier), \(document.summary.documentType), created \(formatDate(document.createdAt))"
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        let calendar = Calendar.current
        let now = Date()
        
        // If within last week, use relative formatting
        if calendar.dateComponents([.day], from: date, to: now).day ?? 0 < 7 {
            return formatter.localizedString(for: date, relativeTo: now)
        }
        
        // Otherwise use absolute date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    private func getIconName(for documentType: String) -> String {
        let lowercased = documentType.lowercased()
        
        if lowercased.contains("loan") || lowercased.contains("credit") {
            return "banknote"
        } else if lowercased.contains("insurance") || lowercased.contains("policy") {
            return "shield.checkered"
        } else if lowercased.contains("contract") || lowercased.contains("agreement") {
            return "doc.text"
        } else if lowercased.contains("lease") || lowercased.contains("rental") {
            return "house"
        } else if lowercased.contains("employment") || lowercased.contains("job") {
            return "briefcase"
        } else if lowercased.contains("investment") || lowercased.contains("portfolio") {
            return "chart.line.uptrend.xyaxis"
        } else if lowercased.contains("tax") || lowercased.contains("receipt") {
            return "receipt"
        } else {
            return "doc.plaintext"
        }
    }
    
    private func getIconColor(for documentType: String) -> UIColor {
        let lowercased = documentType.lowercased()
        
        if lowercased.contains("loan") || lowercased.contains("credit") {
            return .systemGreen
        } else if lowercased.contains("insurance") || lowercased.contains("policy") {
            return .systemBlue
        } else if lowercased.contains("contract") || lowercased.contains("agreement") {
            return .systemPurple
        } else if lowercased.contains("lease") || lowercased.contains("rental") {
            return .systemOrange
        } else if lowercased.contains("employment") || lowercased.contains("job") {
            return .systemIndigo
        } else if lowercased.contains("investment") || lowercased.contains("portfolio") {
            return .systemTeal
        } else if lowercased.contains("tax") || lowercased.contains("receipt") {
            return .systemRed
        } else {
            return .systemGray
        }
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(tap)
    }
    
    @objc private func cellTapped() {
        // Add subtle tap animation
        UIView.animate(withDuration: 0.1, animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.containerView.transform = .identity
            }
        }
        
        guard let doc = currDocument else { return }
        delegate?.homeListCellDidSelect(document: doc)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        documentTypeLabel.text = nil
        dateLabel.text = nil
        iconImageView.image = nil
    }
}
