//
//  OnboardingPagerFlow.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 06/08/2022.
//

import SwiftUI

struct OnboardingPagerFlow: View {
    @State private var currentPage = 0
    var body: some View {
        PagerView(pageCount: 5, currentIndex: $currentPage) {
                    OnboardingPage(title: "Welcome", content: "Sur Veille", systemImageName: "folder.fill"
                    )
                    Color.red
                    Color.green
                    Color.red
                    Color.green
                }
    }
}

struct OnboardingPage: View {
    var title: String
    var content: String
    var systemImageName: String
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(systemName: systemImageName)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .green, .red)
                .font(.system(size: 144))
                .overlay(
                    Circle()
                        .foregroundColor(.secondary)
                )
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            Spacer()
            Text(content)
            Spacer()
        }
    }
}

struct OnboardingPagerFlow_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPagerFlow()
    }
}
