//
//  Network.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 24.11.23.
//

import Foundation
import Alamofire

class Network {
    static let shared = Network()
    
    let userDefaults = UserDefaultsManager.shared
    
    let baseUrl = URL(string: "http://130.193.49.120/backend/api/v1")!
    
    private init() {}
    // MARK: - Auth
    func getAuth(email: String, password: String, completion: @escaping (Error?) -> Void) {
        let url = baseUrl.appending(path: "/auth/login")
        let parameters = [
            "username": email,
            "password": password
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseDecodable(of: Token.self) { response in
            switch response.result {
            case .success(let token):
                self.userDefaults.setToken(token: token.access)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getReg(email: String, password: String, completion: @escaping (Error?) -> Void) {
        
        let url = baseUrl.appending(path: "/auth/reg")
        let auth = AuthRegUser(email: email, password: password)
        AF.request(url, method: .post, parameters: auth, encoder: JSONParameterEncoder.default).responseDecodable(of: Token.self) { response in
            switch response.result {
            case .success(let token):
                self.userDefaults.setToken(token: token.access)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getUser(completion: @escaping (Result<User,Error>) -> Void) {
        let url = baseUrl.appending(path: "/auth/me")
        guard let token = userDefaults.getToken() else {
            completion(.failure(AuthError.authorization))
            return
        }
        let headers = HTTPHeaders(["Authorization":"Bearer \(token)"])
        AF.request(url, headers: headers).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - News, Tags
    func getNews(type: FeedType, completion: @escaping (Result<[News],Error>) -> Void) {
        
        let url = baseUrl.appending(path: "/feed/news")
        guard let token = userDefaults.getToken() else {
            completion(.failure(AuthError.authorization))
            return
        }
        let headers = HTTPHeaders(["Authorization":"Bearer \(token)"])
        AF.request(url, parameters: ["type_feed": type.rawValue], encoding: URLEncoding.default, headers: headers).responseDecodable(of: [News].self) { response in
            switch response.result {
            case .success(let news):
                completion(.success(news))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createNews(_ newPost: NewPost, completion: @escaping (Result<Bool,Error>) -> Void) {
        let url = baseUrl.appending(path: "/feed/new_post")
        guard let token = userDefaults.getToken() else {
            completion(.failure(AuthError.authorization))
            return
        }
        let headers = HTTPHeaders(["Authorization":"Bearer \(token)"])
        AF.request(url, method: .post, parameters: newPost, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: String.self) { response in
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createTag(_ newTag: NewTag, completion: @escaping (Result<Bool,Error>) -> Void) {
        let url = baseUrl.appending(path: "/feed/new_tag")
        guard let token = userDefaults.getToken() else {
            completion(.failure(AuthError.authorization))
            return
        }
        let headers = HTTPHeaders(["Authorization":"Bearer \(token)"])
        AF.request(url, method: .post, parameters: newTag, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: String.self) { response in
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTags(completion: @escaping (Result<[Tag],Error>) -> Void) {
        let url = baseUrl.appending(path: "/feed/tags")
        guard let token = userDefaults.getToken() else {
            completion(.failure(AuthError.authorization))
            return
        }
        let headers = HTTPHeaders(["Authorization":"Bearer \(token)"])
        AF.request(url, headers: headers).responseDecodable(of: [Tag].self) { response in
            switch response.result {
            case .success(let tags):
                completion(.success(tags))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: 
    func getRequests(completion: @escaping (Result<[UserRequest],Error>) -> Void) {
        let url = baseUrl.appending(path: "/user/requests")
        guard let token = userDefaults.getToken() else {
            completion(.failure(AuthError.authorization))
            return
        }
        let headers = HTTPHeaders(["Authorization":"Bearer \(token)"])
        AF.request(url, headers: headers).responseDecodable(of: [UserRequest].self) { response in
            switch response.result {
            case .success(let items):
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createRequest(_ request: NewUserRequest, completion: @escaping (Result<Bool,Error>) -> Void) {
        let url = baseUrl.appending(path: "/user/requests")
        guard let token = userDefaults.getToken() else {
            completion(.failure(AuthError.authorization))
            return
        }
        let headers = HTTPHeaders(["Authorization":"Bearer \(token)"])
        AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
