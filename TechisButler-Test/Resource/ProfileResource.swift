//
//  ProfileResource.swift
//  Dheya IAS
//
//  Created by Madhvendra Singh on 25/04/24.
//

import Foundation

class ProfileResource {
    func getProfile(completion: @escaping ((UserData?, String) -> Void)) {
        Network().getProfile { response in
            switch response {
            case .success(let data):
                guard data.success else {
                    completion(nil, data.message)
                    return
                }
                completion(data.user, "")
            case .failure(_):
                completion(nil, LocalizeKeys().something_went_wrong_please_try_again)
            }
        }
    }
    
    func getState(completion: @escaping (([StateData], String) -> Void)) {
        Network().getStates { response in
            switch response {
            case .success(let data):
                guard data.success else {
                    completion([], data.message)
                    return
                }
                completion(data.state, "")
            case .failure(_):
                completion([], LocalizeKeys().something_went_wrong_please_try_again)
            }
        }
    }
    
    func getCities(stateId: String, completion: @escaping (([CityData], String) -> Void)) {
        Network().getCitie(stateId: stateId) { response in
            switch response {
            case .success(let data):
                guard data.success else {
                    completion([], data.message)
                    return
                }
                completion(data.city, "")
            case .failure(_):
                completion([], LocalizeKeys().something_went_wrong_please_try_again)
            }
        }
    }
}
