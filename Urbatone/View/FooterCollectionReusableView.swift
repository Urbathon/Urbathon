//
//  FooterCollectionReusableView.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {
    static let id = "FooterCollectionReusableView"
    
    let button = UIButton(type: .custom)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews([button])
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        button.contentHorizontalAlignment = .left
        button.setTitle("Все", for: .normal)
        button.setTitleColor(UIColor(resource: .blue), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
