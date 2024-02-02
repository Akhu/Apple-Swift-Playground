//
//  DynamicTypeSizeView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 25/07/2022.
//

import SwiftUI

struct DynamicTypeSizeView: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        let layout = dynamicTypeSize <= .xxxLarge ? AnyLayout(_HStackLayout()) : AnyLayout(_VStackLayout())
        layout {
            Text("Change your dynamic type size to see changes")
                .foregroundColor(.secondary)
            Image(systemName: "1.circle")
            Image(systemName: "2.circle")
            Image(systemName: "3.circle")
        }
        .font(.largeTitle)
    }
}

struct DynamicTypeSizeView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicTypeSizeView()
    }
}
