//
//  PostListViewModel.swift
//  TechisButler-Test
//
//  Created by madhur bansal on 27/04/24.
//

import Foundation

protocol PostListVMDelegate {
    func getPosts(errorMessage: String)
}

class PostListViewModel {
    var userId: Int = 1
    var postArr: [Post] = []
    var delegate: PostListVMDelegate?
    var newPostCount = 0
    var isApiCallInProgress = false
    
    func getData() {
        guard !isApiCallInProgress else {return}
        guard Reachability.isConnectedToNetwork() else {
            self.delegate?.getPosts(errorMessage: "Please check your internet connectivity")
            return
        }
        isApiCallInProgress = true
        PostResource().getPosts(userId: userId) { postArr, errorMessage in
            self.isApiCallInProgress = false
            if self.userId == 1 {
                self.postArr = []
            }
            self.newPostCount = postArr.count
            self.postArr.append(contentsOf: postArr)
            self.delegate?.getPosts(errorMessage: errorMessage)
        }
    }
}
