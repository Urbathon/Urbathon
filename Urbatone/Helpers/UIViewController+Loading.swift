//
//  UIViewController+Loading.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import UIKit

extension UIViewController {
    func showLoadingScreen() {
        // Create an activity indicator
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()

        // Create a semi-transparent background view
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        backgroundView.addSubview(activityIndicator)
        backgroundView.tag = 123
        // Add the background view with the activity indicator to the main view
        view.addSubview(backgroundView)

        // Disable user interaction while the loading screen is visible
        view.isUserInteractionEnabled = false
    }

    func hideLoadingScreen() {
        view.viewWithTag(123)?.removeFromSuperview()

        // Enable user interaction now that the loading screen is hidden
        view.isUserInteractionEnabled = true
    }
}

extension UIViewController {
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showMessage(message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
