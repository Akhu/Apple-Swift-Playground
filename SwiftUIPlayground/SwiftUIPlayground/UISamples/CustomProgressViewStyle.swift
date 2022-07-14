//
//  LoadingBar.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 23/06/2021.
//

import SwiftUI

struct StoryProgressStyle: ProgressViewStyle {
    var strokeColor = Color.white
    var backgroundColor = Color.secondary
    var strokeWidth = 1

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            GeometryReader { geometry in
                ZStack {
                    Path { path in
                        path.move(to: geometry.frame(in: .local).origin)
                        path.addLine(to: CGPoint(x: geometry.frame(in: .local).maxX, y: 0))
                    }.stroke(backgroundColor.opacity(0.6), style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                    Path { path in
                        path.move(to: geometry.frame(in: .local).origin)
                        path.addLine(to: CGPoint(x: geometry.frame(in: .local).maxX, y: 0))
                    }.trim(from: 0, to: CGFloat(fractionCompleted))
                    .stroke(strokeColor.opacity(0.9), style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                }
            }
        }
    }
}

struct LoadingBar: View {
    var progress:CGFloat
    var body: some View {
        ProgressView(value: progress, total: 1.0)
            .progressViewStyle(StoryProgressStyle(strokeWidth:3))
                    .frame(height: 2)
                    
    }
}

struct LoadingBar_Previews: PreviewProvider {
    static var previews: some View {
        LoadingBar(progress: CGFloat(0.2))
    }
}
