//
//  Tag.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import Foundation

struct Tag: Codable {
    let name: String
    let id: Int
}

struct NewTag: Codable {
    let name: String
}
