//
//  BaseViewController.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import UIKit

class BaseViewController: UIViewController {
    var tabBarViewController: TabBarViewController {
        return tabBarController as! TabBarViewController
    }
    
    var sceneDelegate: SceneDelegate {
        return view.window?.windowScene?.delegate as! SceneDelegate
    }
    
    func reload() {
        
    }
}
