//
//  SizeClassView.swift
//  SizeClassView
//
//  Created by Anthony Da cruz on 13/09/2021.
//

import SwiftUI

struct SizeClassView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    
    
    var body: some View {
        if sizeClass == .compact {
            AnyView(HStack {
                Text("Active size class:")
                Text("COMPACT")
            })
                .font(.largeTitle)
        } else {
            AnyView(HStack {
                Text("Active size class:")
                Text("REGULAR")
            })
            .font(.largeTitle)
        }
    }
}

struct SizeClassView_Previews: PreviewProvider {
    static var previews: some View {
        SizeClassView()
    }
}
