//
//  LastHackerNewsView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 21/03/2023.
//

import SwiftUI

struct LastHackerNewsView: View {
    @StateObject var HNState = HackerNewsState()
    var body: some View {
        Button {
            HNState.loadTopStories()
        } label: {
            Text("Test")
        }

    }
}

struct LastHackerNewsView_Previews: PreviewProvider {
    static var previews: some View {
        LastHackerNewsView()
    }
}
