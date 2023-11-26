//
//  AuthModel.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 24.11.23.
//

import Foundation

enum AuthError: Error {
    
    case shortPassword
    case notEmail
    case network(Error)
    case authorization
    
    var message: String {
        switch self {
        case .shortPassword:
            return "Пароль должен быть длиннее 6 символов"
        case .notEmail:
            return "Это не email"
        case .network(_):
            return "Ошибка сервера"
        case .authorization:
            return "Ошибка авторизации"
        }
    }

}

class AuthModel {
    
    var user: User?
    
    func login(email: String?, password: String?, completion: @escaping (Result<Bool,AuthError>) -> Void) {
        guard let email, isValidEmail(email) else {
            completion(.failure(AuthError.notEmail))
            return
        }
        
        guard let password, password.count >= 6 else { completion(.failure(AuthError.shortPassword))
            return
        }
        
        Network.shared.getAuth(email: email, password: password) { [weak self] error in
            
            if let error {
                completion(.failure(.network(error)))
            } else {
                self?.getUser { error in
                    if let error {
                        completion(.failure(.network(error)))
                    } else {
                        completion(.success(true))
                    }
                }
            }
        }
    }
    
    func regUser(email: String?, password: String?, completion: @escaping (Result<Bool,AuthError>) -> Void) {
        guard let email, isValidEmail(email) else {
            completion(.failure(AuthError.notEmail))
            return
        }
        
        guard let password, password.count >= 6 else { completion(.failure(AuthError.shortPassword))
            return
        }
        Network.shared.getReg(email: email, password: password) { error in
            if let error {
                completion(.failure(.network(error)))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func getUser(completion: @escaping (Error?) -> Void) {
        Network.shared.getUser { [weak self] result in
            switch result {
            case .success(let success):
                self?.user = success
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    func signOut() {
        UserDefaultsManager.shared.setToken(token: nil)
        user = nil
    }

}

fileprivate func isValidEmail(_ email: String) -> Bool {
    // Use a regular expression to check for a valid email format
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}
