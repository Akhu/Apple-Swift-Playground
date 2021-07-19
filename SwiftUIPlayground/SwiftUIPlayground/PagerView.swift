//
//  PagerView.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 21/06/2021.
//

import SwiftUI

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content

    @GestureState private var translation: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: 0) {
                    self.content.frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
                .offset(x: self.translation)
                .animation(.interactiveSpring())
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.width
                    }.onEnded { value in
                        let offset = value.translation.width / geometry.size.width
                        let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                        withAnimation(.easeInOut(duration: 0.2)) {
                        self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                        }
                    }
                )
                
                VStack {
                    Spacer()
                    ZStack {
                        HStack {
                            ForEach(0..<self.pageCount, id: \.self) { index in
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 10, height: 10)
                            }
                        }
                        Circle()
                            .fill(Color.black)
                            .frame(width: 10, height: 10)
                            .offset(x: CGFloat(18 * (currentIndex - 1)), y: 0)
                    }
                }
                .offset(y: 16)
            }
        }
    }
}

struct PagerTestView: View {
    @State private var currentPage = 0
    var body: some View {
        PagerView(pageCount: 5, currentIndex: $currentPage) {
                    Color.blue
                    Color.red
                    Color.green
                    Color.red
                    Color.green
                }
    }
}

struct PagerView_Previews: PreviewProvider {
    
    static var previews: some View {
        PagerTestView()
    }
}
