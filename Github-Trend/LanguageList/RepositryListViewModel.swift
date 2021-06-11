//
//  LanguageDetailView.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/06.
//

import Foundation

class RepositryListViewModel: ObservableObject {
    @Published var repos: [Repository] = .init()
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
        print(self.language)
        print(self.page)
        networkingApi.getRepository(language: self.language, page: page) { result in
            switch result {
            case let .success(repos):
                self.repos = repos.results
                print(self.repos)
            case let .failure(error):
                self.errorMessage = error.localizedDescription
                self.isErrorAlert = true
            }
        }
        self.isLoading = false
    }
    
    func checkNextPage(repo: Repository) {
        if repo == repos.last {
            self.page += 1
            self.appendRepositoryList()
        }
    }
    
    private func appendRepositoryList() {
        self.isLoading = true
        networkingApi.getRepository(language: self.language, page: page) { result in
            switch result {
            case let .success(repos):
                self.repos += repos.results
            case let .failure(error):
                self.errorMessage = error.localizedDescription
                self.isErrorAlert = true
            }
        }
        self.isLoading = false
    }
}
