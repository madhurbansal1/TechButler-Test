//
//  Network.swift
//  Sentor
//
//  Created by Madhvendra Singh on 28/09/22.
//

import Foundation
import UIKit
import Alamofire

typealias HTTPResponse<T: Decodable> = (Result<T, ErrorResponse>)->Void

class Network {
    private static let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        return Session(configuration: configuration, interceptor: MyRequestInterceptor())
    }()
    
    private func performRequest<T: Decodable>(_ router: Router, completion: @escaping HTTPResponse<T>) {
        Network.sessionManager.request(router)
            .validate(statusCode: 200..<401)
            .responseDecodable(of: T.self) { response in
#if DEBUG
                if let data = response.data,
                   let json = try? JSONSerialization.jsonObject(with: data, options: []),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                {
                    let jsonStr = String(decoding: jsonData, as: UTF8.self)
                    print(Urls.baseUrl + router.path)
                    print(jsonStr)
                }
#endif
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    let statusCode = response.response?.statusCode ?? 0
                    var responseStr = ""
                    if let data = response.data {
                        responseStr = String(decoding: data, as: UTF8.self)
                    }
                    let host = response.request?.url?.host ?? ""
                    let path = response.request?.url?.path ?? ""
                    let errorModel = ErrorResponse(statusCode: statusCode, response: responseStr, host: host, path: path)
                    completion(.failure(errorModel))
                }
            }
    }

//    private func formDataRequest<T: Decodable>(_ vc: UIViewController, fileName: String , _ data: Data,_ router: Router, completion: @escaping HTTPResponse<T>, showLoader: Bool) {
//        guard Reachability.isConnectedToNetwork() else {
//            let alert = UIAlertController(title: LocalizeKeys().connection_failure, message: LocalizeKeys().please_check_your_internet_connection, preferredStyle: .alert)
//            let retryAction = UIAlertAction(title: LocalizeKeys().retry, style: .default) { _ in
//                self.formDataRequest(vc, fileName: fileName, data, router, completion: completion, showLoader: showLoader)
//            }
//            alert.addAction(retryAction)
//            vc.present(alert, animated: true)
//            return
//        }
//
//        DispatchQueue.main.async {
//            if showLoader {
//                Loader.instance.show(vc)
//            }
//        }
//        sessionManager.upload(multipartFormData: { formData in
//            formData.append(data, withName: "file1", fileName: fileName)
//
//            for (key, value) in router.parameters ?? [:] {
//                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
//                    formData.append(data, withName: key)
//                }
//            }
//        }, with: router)
//        .validate(statusCode: 200..<401)
//        .responseDecodable(of: T.self) { response in
//            if let data = response.data,
//               let json = try? JSONSerialization.jsonObject(with: data, options: []),
//               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//            {
//                let jsonStr = String(decoding: jsonData, as: UTF8.self)
//                print(router.baseUrl + router.path)
//                print(jsonStr)
//            }
//            switch response.result {
//            case .success(let value):
//                DispatchQueue.main.async {
//                    if showLoader {
//                        Loader.instance.hide()
//                    }
//                    completion(.success(value))
//                }
//            case .failure(_):
//                let statusCode = response.response?.statusCode ?? 0
//                var responseStr = ""
//                if let data = response.data {
//                    responseStr = String(decoding: data, as: UTF8.self)
//                }
//                let host = response.request?.url?.host ?? ""
//                let path = response.request?.url?.path ?? ""
//                let errorModel = ErrorResponse(statusCode: statusCode, response: responseStr, host: host, path: path)
//                print(errorModel)
//                DispatchQueue.main.async {
//                    if showLoader {
//                        Loader.instance.hide()
//                    }
//                    completion(.failure(errorModel))
//                }
//            }
//        }
//    }

    func getPosts(userId: Int, completion: @escaping HTTPResponse<[Post]>) {
        performRequest(.posts(userId: userId), completion: completion)
    }
}
