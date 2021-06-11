//
//  NetworkingService.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/06.
//

import Moya

protocol NetworkingService {
    func getLanguage(page: Int, completion: @escaping (Result<LanguageList, Error>) -> Void)
    func getRepository(language: String, page: Int, completion: @escaping (Result<RepositoryList, Error>) -> Void)
    func getTopic(language: String, page: Int, completion: @escaping (Result<TopicList, Error>) -> Void)
    func search(language: String, completion: @escaping (Result<LanguageList, Error>) -> Void)
}

final class NetworkingAPI: NetworkingService {
    let provider: MoyaProvider<GithubAPI>
    
    init(provider: MoyaProvider<GithubAPI> = MoyaProvider<GithubAPI>()) {
        self.provider = provider
    }
    
    func getLanguage(page: Int, completion: @escaping (Result<LanguageList, Error>) -> Void)  {
        provider.request(.getLanguage(page: page)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let decoded = try JSONDecoder().decode(LanguageList.self, from: responseData)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getRepository(language: String, page: Int, completion: @escaping (Result<RepositoryList, Error>) -> Void) {
        provider.request(.getRepository(language: language, page: page)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    print(responseData)
                    let decoded = try JSONDecoder().decode(RepositoryList.self, from: responseData)
                    print(decoded)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getTopic(language: String, page: Int, completion: @escaping (Result<TopicList, Error>) -> Void) {
        provider.request(.getTopic(language: language, page: page)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let decoded = try JSONDecoder().decode(TopicList.self, from: responseData)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func search(language: String, completion: @escaping (Result<LanguageList, Error>) -> Void) {
        provider.request(.searchLanguage(language: language)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let decoded = try JSONDecoder().decode(LanguageList.self, from: responseData)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
