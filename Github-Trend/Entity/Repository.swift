//
//  Repository.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/06.
//

import Foundation

struct RepositoryList: Codable, Equatable {
    var count: Int
    var total_pages: Int
    var results: [Repository]
}

struct Repository: Codable, Equatable, Hashable {
    var url: String
    var star: Int
    var language: String
    var desc: String
    var name: String
    var user: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case star
        case language
        case desc
        case name
        case user
        case createdAt = "created_at"
    }
    
}
