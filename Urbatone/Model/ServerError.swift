//
//  ServerError.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import Foundation

// MARK: - Error
struct ServerError: Codable {
    let detail: [Detail]
}

// MARK: - Detail
struct Detail: Codable {
    let loc: [LOC]
    let msg, type: String
}

enum LOC: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(LOC.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LOC"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
