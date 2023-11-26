//
//  UserDefaultsManager.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 24.11.23.
//

import Foundation

class UserDefaultsManager {
    
    enum Key: String {
        case apiKey
        case secretKey
        case token
        case isSignedIn
    }
    
    static let shared = UserDefaultsManager()
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: Key.token.rawValue)
    }
    func setToken(token: String?) {
        UserDefaults.standard.set(token, forKey: Key.token.rawValue)
        UserDefaults.standard.synchronize()
    }
}
