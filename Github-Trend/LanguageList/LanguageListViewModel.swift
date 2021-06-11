//
//  LanguageListViewModel.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/06.
//

import Foundation

class LanguageListViewModel: ObservableObject {
    @Published var languages: [Language] = .init()
    @Published var searchedLanguage: [Language] = .init()
    @Published var text = ""
    @Published var isEditing = false
    private var page = 1
    @Published var isLoading = false
    @Published var isErrorAlert = false
    @Published var errorMessage = ""
    
    let networkingApi: NetworkingService
    
    init(networkingApi: NetworkingService = NetworkingAPI()) {
        self.networkingApi = networkingApi
    }
    
    func checkNextPage(language: Language) {
        if language == languages.last {
            self.page += 1
            self.appendLanguageList()
        }
    }
    
    func onAppear() {
        if self.page == 1 {
            self.isLoading = true
            networkingApi.getLanguage(page: page) { result in
                switch result {
                case let .success(languages):
                    self.languages = languages.results
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                    self.isErrorAlert = true
                }
            }
            self.isLoading = false
        }
    }
    
    private func appendLanguageList() {
        self.isLoading = true
        networkingApi.getLanguage(page: page) { result in
            switch result {
            case let .success(languages):
                self.languages += languages.results
            case let .failure(error):
                self.errorMessage = error.localizedDescription
                self.isErrorAlert = true
            }
        }
        self.isLoading = false
    }
    
    func search() {
        self.isLoading = true
        networkingApi.search(language: text) { result in
            switch result {
            case let .success(languages):
                self.searchedLanguage = languages.results
            case let .failure(error):
                self.errorMessage = error.localizedDescription
                self.isErrorAlert = true
            }
        }
        self.isLoading = false
    }
}
