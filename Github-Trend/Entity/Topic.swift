//
//  Topic.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/06.
//

import Foundation

struct TopicList: Codable, Equatable {
    var count: Int
    var total_pages: Int
    var results: [Topic]
}

struct Topic: Codable, Equatable, Hashable {
    var name: String
    var language: String
    var count: Int
    var total_count: Int
}
