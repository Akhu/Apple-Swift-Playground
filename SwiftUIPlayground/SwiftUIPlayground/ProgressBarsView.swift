//
//  ProgressBarsView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 08/07/2022.
//

import SwiftUI
import Combine

class AnimationProgressTimer: ObservableObject {
    private let timer1: Timer.TimerPublisher
    //private let timer2: Timer.TimerPublisher
    @Published var progress1Value: Double = 0
    @Published var progress2Value: Double = 0
    private var cancellableSet = Set<AnyCancellable>()
    private var cancellableTimer: Cancellable?
    
    init() {
        self.timer1 = Timer.publish(every: 1, on: .main, in: .default)
        
    }
    
    func pause() {
        self.cancellableTimer?.cancel()
    }
    
    deinit {
        self.pause()
    }
    
    func start() {
        self.timer1.autoconnect()
            .delay(for: 0.8, scheduler: RunLoop.main)
            .map({ _ in
                if self.progress2Value == 1 {
                    return 0
                }
                return self.progress2Value + Double.random(in: 0.02...0.1) 
            })
            .assign(to: \.progress2Value, on: self)
            .store(in: &cancellableSet)
         self.timer1.autoconnect()
            .map({ _ in
                if self.progress1Value == 1 {
                    return 0
                }
                return self.progress1Value + 0.05
            })
            .assign(to: \.progress1Value, on: self)
            .store(in: &cancellableSet)
    }
}

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
