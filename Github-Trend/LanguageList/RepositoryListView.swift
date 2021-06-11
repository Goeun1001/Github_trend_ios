//
//  LanguageDetailView.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/06.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: RepositryListViewModel
    @Environment(\.openURL) var openURL
    
    init(language: String) {
        self.viewModel = RepositryListViewModel(language: language)
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.repos, id: \.self) { repo in
                    RepoListRow(repo: repo)
                        .onAppear {
                            viewModel.checkNextPage(repo: repo)
                        }
                        .onTapGesture {
                            openURL(URL(string: repo.url)!)
                        }
                }
                
            }.listStyle(PlainListStyle())
            ActivityIndicator(isAnimating: $viewModel.isLoading, style: .large)
        }.onAppear() {
            viewModel.page = 1
            viewModel.onAppear()
        }
    }
}

struct RepoListRow: View {
    let repo: Repository
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(repo.user + " / " + repo.name).font(.title2)
            Text(repo.desc)
            HStack {
                Image(systemName: "star")
                Text(String(repo.star))
            }
            Text(repo.createdAt).foregroundColor(.gray)
        }
    }
}


struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(language: "ruby")
    }
}
