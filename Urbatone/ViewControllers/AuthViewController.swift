//
//  AuthViewController.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 24.11.23.
//

import UIKit

class AuthViewController: UIViewController {
        
    @IBOutlet weak var roundedView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var footerLabel: UILabel!
    
    @IBOutlet weak var footerButton: UIButton!
    
    let model = AuthModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundedView.layer.cornerRadius = 12
        stackView.setCustomSpacing(24, after: titleLabel)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        logInButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func buttonTapped() {
        showLoadingScreen()
        model.login(email: emailTextField.text,
                    password: passwordTextField.text) { [weak self] result in
            self?.hideLoadingScreen()
            switch result {
            case .success:
                self?.showHome()
            case .failure(let failure):
                self?.showError(message: failure.message)
            }
        }
    }
    
    func showHome() {
        if let scene = view.window?.windowScene?.delegate as? SceneDelegate {
            scene.showTabbar()
        }
    }
    
}
