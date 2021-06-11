//
//  TopicDetailViewModel.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/10.
//

import Foundation

class TopicListViewModel: ObservableObject {
    @Published var topics: [Topic] = [Topic(name: "", language: "", count: 1, total_count: 1)]
    @Published var isLoading = false
    @Published var isErrorAlert = false
    @Published var errorMessage = ""
    var page = 1
    let language: String
    
    let networkingApi: NetworkingService
    
    init(networkingApi: NetworkingService = NetworkingAPI(), language: String) {
        self.networkingApi = networkingApi
        self.language = language
    }
    
    func onAppear() {
        self.isLoading = true
        print(page)
        networkingApi.getTopic(language: self.language, page: page) { result in
            switch result {
            case let .success(topics):
                self.topics = topics.results
            case let .failure(error):
                self.errorMessage = error.localizedDescription
                self.isErrorAlert = true
            }
        }
        self.isLoading = false
    }
    
    func checkNextPage(topic: Topic) {
        if topic == topics.last {
            self.page += 1
            self.appendTopicList()
        }
    }
    
    private func appendTopicList() {
        self.isLoading = true
        networkingApi.getTopic(language: self.language, page: page) { result in
            switch result {
            case let .success(topics):
                self.topics += topics.results
            case let .failure(error):
                self.errorMessage = error.localizedDescription
                self.isErrorAlert = true
            }
        }
        self.isLoading = false
    }
}
