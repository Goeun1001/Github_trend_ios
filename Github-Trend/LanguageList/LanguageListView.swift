//
//  LanguageListView.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/06.
//

import SwiftUI

struct LanguageListView: View {
    @ObservedObject var viewModel = LanguageListViewModel()
    let flag: Flag
    
    enum Flag: String {
        case repository
        case topic
    }
    
    init(flag: Flag) {
        self.flag = flag
    }
    
    var body: some View {
        VStack {
            // MARK: - Search Bar
            HStack {
                TextField("Search ...", text: $viewModel.text, onEditingChanged: { _ in
                    viewModel.search()
                })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if viewModel.isEditing {
                            Button(action: {
                                viewModel.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    viewModel.isEditing = true
                }
                
                if viewModel.isEditing {
                    Button(action: {
                        viewModel.isEditing = false
                        viewModel.text = ""
                        
                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
            
            ZStack {
                List {
                    ForEach(viewModel.text != "" ? viewModel.searchedLanguage : viewModel.languages, id: \.language) { language in
                        ZStack {
                            LanguageListRow(language: language)
                                .onAppear {
                                    viewModel.checkNextPage(language: language)
                                }
                            if flag.rawValue == "repository" {
                                NavigationLink(
                                    destination: RepositoryListView(language: language.language)) { }
                                    .frame(width: 0, height: 0)
                                    .hidden()
                            } else {
                                NavigationLink(
                                    destination: TopicListView(language: language.language)) { }
                                    .frame(width: 0, height: 0)
                                    .hidden()
                            }
                        }
                    }
                    
                }.listStyle(PlainListStyle())
                ActivityIndicator(isAnimating: $viewModel.isLoading, style: .large)
            }
        }.alert(isPresented: $viewModel.isErrorAlert) {
            Alert(title: Text(""), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("LanguageList", displayMode: .large)
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

struct LanguageListRow: View {
    let language: Language
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(language.language).font(.title2)
            }
        }
    }
}

struct LanguageListView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageListView(flag: .repository)
    }
}
