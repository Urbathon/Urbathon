//
//  RequestCollectionViewCell.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 26.11.23.
//

import UIKit

class RequestCollectionViewCell: UICollectionViewCell {
    
    static let id = "RequestCollectionViewCell"
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desctiptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
        contentView.subviews.first?.layer.cornerRadius = 12
        
        // Initialization code
    }

}
