//
//  Language.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/06.
//

import Foundation

struct LanguageList: Codable, Equatable {
    var count: Int
    var total_pages: Int
    var results: [Language]
}

struct Language: Codable, Equatable {
    var language: String
    var count: Int
}
