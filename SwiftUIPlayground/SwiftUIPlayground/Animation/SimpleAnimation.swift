//
//  SimpleAnimation.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da Cruz on 23/01/2024.
//

import SwiftUI

struct SimpleAnimation: View {
    
    @State var isAnimated = false
    var body: some View {
        VStack {
            Text("Hello World")
                .padding()
                .foregroundStyle(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12.0))
                .offset(y: isAnimated ? 100 : 0)
                .scaleEffect(isAnimated ? 2.0 : 1)
                .animation(.bouncy, value: isAnimated)
        }
        .onTapGesture {
            isAnimated.toggle()
        }
    }
}

#Preview {
    SimpleAnimation()
}
