//
//  ShareLinkView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 14/07/2022.
//

import SwiftUI

struct Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }

    public var image: Image
    public var caption: String
}

struct ShareLinkView: View {
    let photo: Photo = Photo(image: Image("image-2"), caption: "Some beautiful mountain")
    
    var body: some View {
        
        let link = URL(string: "https://blog.async-agency.com")!
        VStack(alignment: .leading) {
            photo.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 250)
                .cornerRadius(8)
                .toolbar {
                    ShareLink(
                        item: photo,
                        preview: SharePreview(
                            photo.caption,
                            image: photo.image))
                }
            ShareLink(item: link, message: Text("Best tech blog in French 🇫🇷"))
            ShareLink("Learn things here", item: link)
            ShareLink(item: link) {
                Label("Learn Tech, Mobile, News and Design here", systemImage: "bolt.circle.fill")
            }
            ShareLink(Text("Title"), item: link, preview: SharePreview("Test ?", image: Image(systemName: "plus")))
            Spacer()
        }.navigationTitle(Text("Share Link"))
    }
}

struct ShareLinkView_Previews: PreviewProvider {
    static var previews: some View {
        ShareLinkView()
    }
}
