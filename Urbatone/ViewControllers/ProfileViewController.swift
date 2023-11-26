//
//  ProfileViewController.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 24.11.23.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var singOutButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        singOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        imageView.layer.cornerRadius = 60
    }
    
    @objc func signOut() {
        tabBarViewController.authModel.signOut()
        sceneDelegate.showAuth()
    }
    
}
