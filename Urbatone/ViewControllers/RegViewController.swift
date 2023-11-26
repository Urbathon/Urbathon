//
//  RegViewController.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import UIKit

class RegViewController: UIViewController {
    @IBOutlet weak var roundedView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var userAgreement: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var footerButton: UIButton!
    
    @IBOutlet weak var userAgreementButton: UIButton!
    let model = AuthModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundedView.layer.cornerRadius = 12
        stackView.setCustomSpacing(24, after: titleLabel)

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        logInButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        footerButton.addTarget(self, action: #selector(hideScreen), for: .touchUpInside)
    }
    
    @objc func hideScreen() {
        dismiss(animated: true)
    }
    
    @objc func buttonTapped() {
        showLoadingScreen()
        model.regUser(email: emailTextField.text,
                    password: passwordTextField.text) { [weak self] result in
            self?.hideLoadingScreen()
            switch result {
            case .success:
                self?.showMessage(message: "Пользователь был создан") { _ in
                    self?.dismiss(animated: true)
                }
            case .failure(let failure):
                self?.showError(message: failure.message)
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showHome() {
        if let scene = view.window?.windowScene?.delegate as? SceneDelegate {
            scene.showTabbar()
        }
    }
    
}
