//
//  3DRotationEffectAnimation.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 19/07/2021.
//
import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .bottomLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .bottomLeading)
        )
    }
}

/*
-----------------
3D rotation effect
*/
struct AnimationPlayground: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    
    var body: some View {
        Button("Tap Me") {
            enabled.toggle()
            // do nothing
            //Or
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) { self.animationAmount += 360
            }
        }
        .padding(50)
        .background(enabled ? Color.blue : Color.red)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.default)
        .foregroundColor(.white)
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.0, y: 1.0, z: 0.0)
            )
        
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

struct AnimationPlayground_Previews: PreviewProvider {
    static var previews: some View {
        AnimationPlayground()
    }
}
