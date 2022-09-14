//
//  SizeClassView.swift
//  SizeClassView
//
//  Created by Anthony Da cruz on 13/09/2021.
//

import SwiftUI

struct SizeClassView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    //New in iOS 16 : AnyLayout -> Try on Max devices or iPAD to see it
    
    var body: some View {
        let layout = sizeClass == .regular ? AnyLayout(_HStackLayout()) : AnyLayout(_VStackLayout())
        
        layout {
            Text("Change your device orientation (Max iphones and iPad) to see changes")
                .foregroundColor(.secondary)
            Image(systemName: "1.circle")
            Image(systemName: "2.circle")
            Image(systemName: "3.circle")
        
            if sizeClass == .compact {
               
                    Text("Active size class:")
                    Text("COMPACT")
            } else {
                    Text("Active size class:")
                    Text("REGULAR")
            }
        }
        .navigationTitle("Any Layout and Size Classes")
        .font(.largeTitle)
        
        
    }
}

struct SizeClassView_Previews: PreviewProvider {
    static var previews: some View {
        SizeClassView()
    }
}
