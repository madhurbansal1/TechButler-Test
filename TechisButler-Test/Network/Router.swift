//
//  Router.swift
//  Sentor
//
//  Created by Madhvendra Singh on 28/09/22.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case posts(userId: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .posts:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .posts:
            return Urls.posts
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case.posts:
            return [:]
        }
    }

    var isJson: Bool {
        switch self {
        default:
            return false
        }
    }
    
    var queryItems: [String: String] {
        switch self {
        case .posts(userId: let userId):
            return [
                "userId": userId.description
            ]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var items: [URLQueryItem] = []
        for item in queryItems {
            items.append(URLQueryItem(name: item.key, value: item.value))
        }
        var components = URLComponents(string: Urls.baseUrl + path)
        if items.count != 0 {
            components?.queryItems = items
        }
        
        var urlRequest = URLRequest(url: components!.url!)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.agent.rawValue, forHTTPHeaderField: HTTPHeaderField.userAgent.rawValue)
        if isJson {
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
            
            return urlRequest
        } else {
            urlRequest.setValue(ContentType.form.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            guard method == .get else {
                if let parameters = parameters {
                    do {
                        return try URLEncoding.httpBody.encode(urlRequest, with: parameters)
                    } catch {
                        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                    }
                }
                return urlRequest
            }
            return urlRequest//try URLEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
