//
//  UserRequestModel.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 26.11.23.
//

import Foundation

class UserRequestModel {
    
    var requests: [UserRequest] = []
    
    func getRequests(completion: @escaping (Error?) -> Void) {
        Network.shared.getRequests { [weak self] result in
            switch result {
            case .success(let success):
                self?.requests = success.sorted(by: { $0.dateUpdate > $1.dateUpdate })
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    func createUserRequest(_ request: NewUserRequest, completion: @escaping (Error?) -> Void) {
        Network.shared.createRequest(request) { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
}
