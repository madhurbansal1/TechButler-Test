//
//  RequestInterceptor.swift
//  Sentor
//
//  Created by Madhvendra Singh on 28/09/22.
//

import Foundation
import Alamofire
import UIKit

final class MyRequestInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard
            let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        completion(.doNotRetryWithError(error))
        // token expired refresh token
//        Network.instance.refreshToken(vc: nil) { response in
//            switch response {
//            case .success(let data):
//                LocalValues.instance.authToken = data.accessToken?.stringValue ?? ""
//                completion(.retry)
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(.doNotRetryWithError(error))
//            }
//        }
    }
}
