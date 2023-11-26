//
//  HeaderCollectionReusableView.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    static let id = "HeaderCollectionReusableView"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
