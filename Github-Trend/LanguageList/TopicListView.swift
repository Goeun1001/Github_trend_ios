//
//  LanguageDetailView.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/06.
//

import SwiftUI

struct TopicListView: View {
    @ObservedObject var viewModel: TopicListViewModel
    @Environment(\.openURL) var openURL
    
    init(language: String) {
        self.viewModel = TopicListViewModel(language: language)
    }
    
    var body: some View {
        ZStack {
            List {
                Text("총 토픽개수: \(viewModel.topics.first!.total_count) 개")
                ForEach(viewModel.topics, id: \.self) { topic in
                    TopicListRow(topic: topic)
                        .onAppear {
                            viewModel.checkNextPage(topic: topic)
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

struct TopicListRow: View {
    let topic: Topic
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(topic.name)
                ZStack(alignment: .leading) {
                    Rectangle().frame(height: 10)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    Rectangle().frame(width: min(CGFloat(Double(self.topic.count) / Double(self.topic.total_count))*geometry.size.width, geometry.size.width), height: 10)
                            .foregroundColor(Color(UIColor.systemBlue))
                            .animation(.linear)
                }.cornerRadius(45.0)
                Text("\(topic.count)개")
            }
        }
    }
}


struct TopicListView_Previews: PreviewProvider {
    static var previews: some View {
        TopicListView(language: "ruby")
    }
}
