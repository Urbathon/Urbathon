//
//  FAQCollectionViewCell.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import UIKit

class FAQCollectionViewCell: UICollectionViewCell {
    
    static let id = "FAQCollectionViewCell"
    
    let titleLabel = UILabel()
    let imageView = UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(UIColor(resource: .blue), renderingMode: .alwaysOriginal))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([titleLabel, imageView])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 12),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

