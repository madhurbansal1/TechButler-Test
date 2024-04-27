//
//  ErrorResponse.swift
//  Sentor
//
//  Created by Madhvendra Singh on 28/09/22.
//

import Foundation

struct ErrorResponse: Codable, Error {
    var statusCode: Int
    var response: String
    var host: String
    var path: String
}
