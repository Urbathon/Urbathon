//
//  NewsCollectionViewCell.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    static let id = "NewsCollectionViewCell"
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let tagView = UIView()
    let tagLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tagView.addSubviews([tagLabel])
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubviews([imageView, titleLabel, tagView])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            tagView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            tagView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            tagLabel.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 2),
            tagLabel.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 2),
            tagLabel.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -2),
            tagLabel.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -2),

        ])
        imageView.contentMode = .scaleAspectFill
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        titleLabel.textColor = .white
        tagLabel.textColor = UIColor(resource: .blue)
        tagView.layer.cornerRadius = 4
        tagView.layer.borderColor = UIColor(resource: .blue).cgColor
        tagView.layer.borderWidth = 1/2
        tagView.clipsToBounds = true
        tagView.layer.backgroundColor = UIColor.white.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
