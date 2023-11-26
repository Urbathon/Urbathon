//
//  CreateRequestViewController.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 26.11.23.
//

import UIKit

class CreateRequestViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    var request: NewUserRequest!
    
    let scrollView = UIScrollView()
    
    // Create an array to hold text fields
    var textFields: [UITextField] = []
    let menuButton = UIButton(type: .custom)
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        
        let backgroundView = UIView(frame: .init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 4))
        backgroundView.backgroundColor = UIColor(resource: .blue)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
        
        // Set up UIScrollView
        scrollView.frame = view.bounds
        scrollView.contentSize = view.bounds.size
        scrollView.keyboardDismissMode = .onDrag
        scrollView.contentInsetAdjustmentBehavior = .always
        view.addSubview(scrollView)
        
        // Set up form elements
        setupForm()
    }
    
    // MARK: Helper Methods
    
    func setupForm() {
        var yOffset: CGFloat = 20
        
        let textField1 = UITextField(frame: CGRect(x: 20, y: yOffset, width: view.bounds.width - 40, height: 40))
        textField1.placeholder = "Тема запроса"
        textField1.borderStyle = .roundedRect
        textField1.delegate = self
        textFields.append(textField1)
        scrollView.addSubview(textField1)
        
        yOffset += 60

        let textField2 = UITextField(frame: CGRect(x: 20, y: yOffset, width: view.bounds.width - 40, height: 40))
        textField2.placeholder = "Адрес"
        textField2.borderStyle = .roundedRect
        textField2.delegate = self
        textFields.append(textField2)
        scrollView.addSubview(textField2)
        
        yOffset += 60

        
        menuButton.setTitle("Выберете категории проблемы", for: .normal)
        menuButton.frame = CGRect(x: 20, y: yOffset, width: view.bounds.width - 40, height: 40)
        let action1 = UIAction(title: "Прорыв Труб") { _ in
            self.menuButton.setTitle("Прорыв Труб", for: .normal)
        }
        
        let action2 = UIAction(title: "Авария") { _ in
            self.menuButton.setTitle("Авария", for: .normal)
        }
        
        let action3 = UIAction(title: "Сбежала кошка") { _ in
            self.menuButton.setTitle("Сбежала кошка", for: .normal)
        }
        
        let action4 = UIAction(title: "Нет электричества") { _ in
            self.menuButton.setTitle("Нет электричества", for: .normal)
        }
        let menu = UIMenu(options: .singleSelection, children: [action1, action2, action3, action4])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
        menuButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        menuButton.setTitleColor(UIColor(resource: .blue), for: .normal)
        scrollView.addSubview(menuButton)
        yOffset += 60
                
        let textField4 = UITextField(frame: CGRect(x: 20, y: yOffset, width: view.bounds.width - 40, height: 40))
        textField4.placeholder = "Описание запроса"
        textField4.borderStyle = .roundedRect
        textField4.delegate = self
        textFields.append(textField4)
        scrollView.addSubview(textField4)
        
        yOffset += 60
        
        let textField5 = UITextField(frame: CGRect(x: 20, y: yOffset, width: view.bounds.width - 40, height: 40))
        textField5.placeholder = "Комментарий"
        textField5.borderStyle = .roundedRect
        textField5.delegate = self
        textFields.append(textField5)
        scrollView.addSubview(textField5)
        
        yOffset += 60
        
        let button2 = UIButton(type: .custom)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button2.backgroundColor = UIColor(resource: .blue)
        button2.layer.cornerRadius = 8
        button2.setTitle("Отправить", for: .normal)
        button2.frame = CGRect(x: 20, y: yOffset, width: view.bounds.width - 40, height: 40)
        button2.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        scrollView.addSubview(button2)
        
        // Set the scroll view content size based on the total height of form elements
        scrollView.contentSize = CGSize(width: view.bounds.width, height: yOffset + 60)
    }
    
    // MARK: UITextFieldDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Move to the next text field or dismiss the keyboard if it's the last one
        if let index = textFields.firstIndex(of: textField), index < textFields.count - 1 {
            textFields[index + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: Button Action
    
    @objc func submitButtonTapped() {
        // Handle the submit button action here
        showLoadingScreen()
        let date = Int(Date().timeIntervalSince1970)
        let request = NewUserRequest(status: "new",
                                     title: textFields[0].text ?? "",
                                     description: textFields[2].text ?? "",
                                     address: textFields[1].text ?? "",
                                     categoryProblem: menuButton.title(for: .normal),
                                     comment: textFields[3].text ?? "",
                                     dateCreate: date,
                                     dateUpdate: date)
        tabBarViewController.requestsModel.createUserRequest(request) { [weak self] error in
            self?.hideLoadingScreen()
            if let error {
                self?.showError(message: "Ошбика создания запроса")
            } else {
                self?.tabBarViewController.updateRequests()
                self?.navigationController?.viewControllers.first?.showLoadingScreen()
                self?.showMessage(message: "Запрос успешно создан") { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        
    }
}

