//
//  AddMoreViewCell.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 25/10/25.
//

import UIKit

class AddMoreViewCell: UICollectionViewCell {
    
    static let identifier = "AddMoreViewCell"
    
    let addButton: UILabel = {
        let label = UILabel()
        label.text = "Add more +"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        
        contentView.isUserInteractionEnabled = true
        
        contentView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


#Preview{
    AddMoreViewCell()
}

