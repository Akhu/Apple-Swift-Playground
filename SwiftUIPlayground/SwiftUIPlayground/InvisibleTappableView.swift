//
//  InvisibleTappableView.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 23/06/2021.
//

import SwiftUI

struct InvisibleTappableView: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear.contentShape(Path(CGRect(origin: .zero, size: geometry.size)))
        }
    }
}

struct InvisibleTappableView_Previews: PreviewProvider {
    static var previews: some View {
        InvisibleTappableView()
    }
}
