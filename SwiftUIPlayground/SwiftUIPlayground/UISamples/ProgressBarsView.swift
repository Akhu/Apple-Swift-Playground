//
//  ProgressBarsView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 08/07/2022.
//

import SwiftUI
import Combine

struct ProgressBarsView: View {
    @StateObject var animationTimer = AnimationProgressTimer()
    var body: some View {
        VStack(spacing: 24) {
            
                Group {
                    ProgressView("🦠 Suppression du virus", value: animationTimer.progress1Value)
                    .font(.headline)
                    .animation(.easeInOut, value: animationTimer.progress1Value)
            
                    ProgressView("🧠 Rééducation du système autonome", value: animationTimer.progress2Value)
                        .font(.headline)
                        .animation(.easeInOut, value: animationTimer.progress2Value)
            }
            
        }
        .padding()
        .onAppear {
            animationTimer.start()
        }
    }
}

struct ProgressBarsView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarsView()
    }
}
