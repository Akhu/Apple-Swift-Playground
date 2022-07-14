//
//  ShareLinkView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 14/07/2022.
//

import SwiftUI

struct ShareLinkView: View {
    
    var body: some View {
        let link = URL(string: "https://blog.async-agency.com")!
        VStack(alignment: .leading) {
            ShareLink(item: link, message: Text("Best tech blog in French 🇫🇷"))
            ShareLink("Learn things here", item: link)
            ShareLink(item: link) {
                Label("Learn Tech, Mobile, News and Design here", systemImage: "bolt.circle.fill")
            }
            Spacer()
        }.navigationTitle(Text("Share Link"))
    }
}

struct ShareLinkView_Previews: PreviewProvider {
    static var previews: some View {
        ShareLinkView()
    }
}
