//
//  PostModel.swift
//  TechisButler-Test
//
//  Created by madhur bansal on 27/04/24.
//

import Foundation

struct Post: Codable {
    let userID, id: AnyCodable?
    let title, body: AnyCodable?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
