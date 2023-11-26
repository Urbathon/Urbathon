//
//  TabBarViewController.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 24.11.23.
//

import UIKit



class TabBarViewController: UITabBarController,UITabBarControllerDelegate {
    
    let authModel = AuthModel()
    let newsModel = NewsModel()
    let requestsModel = UserRequestModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dispatchGroup = DispatchGroup()
        
        guard authModel.user == nil else { return }
        showLoadingScreen()
        dispatchGroup.enter()
        authModel.getUser { [weak self] error in
            dispatchGroup.leave()
            if let error {
                self?.showMessage(message: "Не удалось получить пользователя")
            }
        }
        dispatchGroup.enter()
        newsModel.getNews(type: .news) { [weak self] error in
            dispatchGroup.leave()
            if let error {
                self?.showMessage(message: "Не удалось получить новости")
            }
        }
        dispatchGroup.enter()
        newsModel.getNews(type: .event) { [weak self] error in
            dispatchGroup.leave()
            if let error {
                self?.showMessage(message: "Не удалось получить ивенты")
            }
        }
        dispatchGroup.enter()
        newsModel.getNews(type: .eco) { [weak self] error in
            dispatchGroup.leave()
            if let error {
                self?.showMessage(message: "Не удалось получить eco")
            }
        }
        dispatchGroup.enter()
        newsModel.getNews(type: .repair_work) { [weak self] error in
            dispatchGroup.leave()
            if let error {
                self?.showMessage(message: "Не удалось получить ремонтные работы")
            }
        }
        dispatchGroup.enter()
        newsModel.getTags { [weak self] error in
            dispatchGroup.leave()
            if let error {
                self?.showMessage(message: "Не удалось получить тэги")
            }
        }
        dispatchGroup.enter()
        requestsModel.getRequests { [weak self] error in
            dispatchGroup.leave()
            if let error {
                self?.showMessage(message: "Не удалось получить реквесты")
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.hideLoadingScreen()
            ((self.selectedViewController as? UINavigationController)?.topViewController as? BaseViewController)?.reload()
        }
    }
    
    func updateRequests() {
        showLoadingScreen()
        requestsModel.getRequests { [weak self] error in
            if let error {
                self?.showMessage(message: "Не удалось получить реквесты")
            } else {
                self?.hideLoadingScreen()
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    ((self?.selectedViewController as? UINavigationController)?.topViewController as? BaseViewController)?.reload()
                }

            }
        }

    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }

}
