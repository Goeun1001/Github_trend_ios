//
//  MainView.swift
//  Github-Trend
//
//  Created by GoEun Jeong on 2021/06/10.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: LanguageListView(flag: .repository)) {
                    MainRow(title: "언어별 레포지토리")
                }
                NavigationLink(destination: LanguageListView(flag: .topic)) {
                    MainRow(title: "언어별 토픽")
                }
            }.navigationTitle("깃허브 트렌드")
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct MainRow: View {
    let title: String
    
    var body: some View {
        HStack(spacing: 20) {
            Text(title).font(.title)
            Image(systemName: "arrow.right").resizable()
                .frame(width: 20, height: 15)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
