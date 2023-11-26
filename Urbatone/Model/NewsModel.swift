//
//  NewsModel.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 25.11.23.
//

import Foundation

class NewsModel {
    
    var news: [News] = []
    var tags: [Tag] = []
    
    func getNews(type: FeedType, completion: @escaping (Error?) -> Void) {
        Network.shared.getNews(type: type) { [weak self] result in
            switch result {
            case .success(let success):
                self?.news = success
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    func getTags(completion: @escaping (Error?) -> Void) {
        Network.shared.getTags { [weak self] result in
            switch result {
            case .success(let success):
                self?.tags = success
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    func createNewPost(_ newPost: NewPost, completion: @escaping (Error?) -> Void) {
        Network.shared.createNews(newPost) { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    func createNewTag(_ newTag: NewTag, completion: @escaping (Error?) -> Void) {
        Network.shared.createTag(newTag) { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
}
