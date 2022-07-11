//
//  LazyGridView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 21/06/2022.
//

import SwiftUI
import Foundation

struct LazyGridView: View {
    
    let columns = [
            GridItem(.adaptive(minimum: 180))
        ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach((0..<20), id: \.self) { element in
                    Card()
                        .frame(height: 250)
                }
            }
        }
    }
}

struct LazyGridView_Previews: PreviewProvider {
    static var previews: some View {
        LazyGridView()
    }
}

struct Card: View {
    var body: some View {
        VStack {
            Image("image-\(Int.random(in: 1..<6))")
                .centerCropped()
            VStack {
                Text("Image Title")
                    .font(.title)
                Text("Image description")
                    .font(.caption)
                
            }
        }
    }
}
