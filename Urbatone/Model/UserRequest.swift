//
//  UserRequest.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 26.11.23.
//

import Foundation

struct UserRequest: Codable {
    let status, title, description, address: String
    let categoryProblem, comment: String
    let dateCreate, dateUpdate: Int
    let id: Int

    enum CodingKeys: String, CodingKey {
        case status, title, description, address
        case categoryProblem = "category_problem"
        case comment
        case dateCreate = "date_create"
        case dateUpdate = "date_update"
        case id
    }
}

struct NewUserRequest: Codable {
    let status, title, description, address: String?
    let categoryProblem, comment: String?
    let dateCreate, dateUpdate: Int?

    enum CodingKeys: String, CodingKey {
        case status, title, description, address
        case categoryProblem = "category_problem"
        case comment
        case dateCreate = "date_create"
        case dateUpdate = "date_update"
    }
}
