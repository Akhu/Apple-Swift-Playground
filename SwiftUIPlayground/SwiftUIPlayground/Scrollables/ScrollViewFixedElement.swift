//
//  ScrollViewFixedElement.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 22/08/2021.
//

import SwiftUI
import UIKit

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct ScrollViewWithStatusBar<Content: View> : View{
    let content: Content
    private let window: UIWindow?
    
    private let topPadding: CGFloat
    private let bottomPadding: CGFloat
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        
        self.window = keyWindow
                    self.topPadding = keyWindow?.safeAreaInsets.top ?? 0
        self.bottomPadding = keyWindow?.safeAreaInsets.bottom ?? 0
        print(self.topPadding)
    }
    
    var body: some View {
        ScrollView {
            content
        }
        .overlay(
            Group {
                ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: self.topPadding, idealHeight: self.topPadding, maxHeight: self.topPadding)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: self.topPadding, idealHeight: self.topPadding, maxHeight: .infinity, alignment: .top)
            
            .edgesIgnoringSafeArea(.top)
            
        )
    }
}


struct ScrollViewFixedElement: View {
    var body: some View {
        ScrollViewWithStatusBar {
            VStack(alignment: .trailing) {
                ForEach(1..<50) { i in
                    Label("Row \(i)", systemImage: "\(i).circle.fill")
                        .frame(minWidth: 0,idealWidth: .infinity, maxWidth: .infinity)
                }
            }
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity)
            .padding(.top, 70)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
}

struct ScrollViewFixedElement_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewFixedElement()
    }
}
