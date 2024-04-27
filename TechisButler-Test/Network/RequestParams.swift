//
//  RequestParams.swift
//  Sentor
//
//  Created by Madhvendra Singh on 28/09/22.
//

import Foundation

class RequestParams {
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case userAgent = "x-user-agent"
}

enum ContentType: String {
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
    case text = "text/html"
    case agent = "ios"
}
