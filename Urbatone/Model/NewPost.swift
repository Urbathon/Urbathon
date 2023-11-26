//
//  NewPost.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import Foundation

// MARK: - News
struct NewPost: Codable {
    let typePost, title, description, datePost: String
    let dateStart, dateEnd, address: String?
    let images, coordinates, tags: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case typePost = "type_post"
        case title, description
        case datePost = "date_post"
        case dateStart = "date_start"
        case dateEnd = "date_end"
        case address, images, coordinates, tags
    }
}
