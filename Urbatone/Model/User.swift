//
//  User.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import Foundation

//enum TypeUser 

class User: Codable {
    let id: Int
    let email: String
    let typeUser: String 
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case typeUser = "type_user"
    }
}
