//
//  UserListCell.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import Foundation
import UIKit


final class UserListCell: BaseTableViewCell {
    
    private lazy var rootView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.edgeInsets(topSpacing: 16, bottomSpacing: 16, leadingSpacing: 16, trailingSpacing: 16)
        stackView.radius(radius: 8)
        stackView.spacing = 8
        stackView.backgroundColor = .black
        stackView.shadow(opacity: 0.1)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        
        rootView.addArrangedSubviews([
            titleLabel,
            descriptionLabel
        ])
        addSubview(rootView)
    }
    
    override func setupVisuals() {
        super.setupVisuals()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
                
        NSLayoutConstraint.activate([
            rootView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            rootView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rootView.topAnchor.constraint(equalTo: topAnchor),
            rootView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - Fill
extension UserListCell {
    func fill(with item: User) {
        titleLabel.text = item.name
        descriptionLabel.text = item.address.street
    }
}
