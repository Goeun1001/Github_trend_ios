//
//  GithubAPI.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/06.
//

import Moya

enum GithubAPI {
    case getLanguage(page: Int)
    case getRepository(language: String, page: Int)
    case getTopic(language: String, page: Int)
    case searchLanguage(language: String)
    case randomLanguage
    case getYear
}

extension GithubAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:8000")!
    }
    
    var path: String {
        switch self {
        case .getLanguage:
            return "/language"
        case .getRepository:
            return "/language/repo"
        case .getTopic:
            return "/topic/lang"
        case .searchLanguage:
            return "/language/search"
        case .randomLanguage:
            return "/language/random"
        case .getYear:
            return "/year"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getLanguage(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case .getRepository(let language, let page):
            return .requestParameters(parameters: ["q": language, "page": page], encoding: URLEncoding.queryString)
        case .getTopic(let language, let page):
            return .requestParameters(parameters: ["q": language, "page": page], encoding: URLEncoding.queryString)
        case .searchLanguage(let language):
            return .requestParameters(parameters: ["q": language], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
}
