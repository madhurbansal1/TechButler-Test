//
//  PostResource.swift
//  TechisButler-Test
//
//  Created by madhur bansal on 27/04/24.
//

import Foundation

class PostResource {
    func getPosts(userId: Int, completion: @escaping (([Post], String) -> Void)) {
        Network().getPosts(userId: userId) { response in
            switch response {
            case .success(let data):
                completion(data, "")
            case .failure(_):
                completion([], "Something went wrong, Please try again")
            }
        }
    }
}
