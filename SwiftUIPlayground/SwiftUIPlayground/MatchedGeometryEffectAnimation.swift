//
//  AnimationTests.swift
//  Animations
//
//  Created by Anthony Da cruz on 19/06/2021.
//

import SwiftUI

struct MatchedGeometryEffectAnimation: View {
        @Namespace private var animation
        @State private var isZoomed = false

        var frame: CGFloat {
            isZoomed ? 300.0 : 44.0
        }

        var body: some View {
            VStack {
                Spacer()

                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: frame, height: frame)
                            .padding(.top, isZoomed ? CGFloat(20.0) : CGFloat(0.0))

                        if isZoomed == false {
                            Text("Taylor Swift – 1989")
                                .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                                .font(.headline)
                            Spacer()
                        }
                    }

                    if isZoomed == true {
                        Text("Taylor Swift – 1989")
                            .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                            .font(.headline)
                            .padding(.bottom, 60)
                        Spacer()
                    }
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        isZoomed.toggle()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: isZoomed ? CGFloat(400.0) : CGFloat(60.0))
                .background(Color(white: 0.9))
            }
        }
    }

struct MatchedGeometryEffectAnimation_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectAnimation()
    }
}
