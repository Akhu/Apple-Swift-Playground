//
//  DrawingsView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da Cruz on 26/01/2024.
//

import SwiftUI

struct DrawingsParticle {
    let position: CGPoint
    let deathDate = Date.now.timeIntervalSinceReferenceDate + 1
}

class ParticleSystem {
    var particles = [DrawingsParticle]()
    var position = CGPoint.zero

    func update(date: TimeInterval) {
        particles = particles.filter { $0.deathDate > date }
        particles.append(DrawingsParticle(position: position))
    }
}

struct DrawingsView: View {
    
    @State private var particleSystem = ParticleSystem()
    var body: some View {
        VStack {
            TimelineView(.animation) { timeline in
                Canvas { ctx, size in
                    let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                    particleSystem.update(date: timelineDate)

                    for particle in particleSystem.particles {
                        ctx.opacity = particle.deathDate - timelineDate
                        ctx.blendMode = .plusLighter
                        ctx.addFilter(.blur(radius: 10))
                        ctx.fill(Circle().path(in: CGRect(x: particle.position.x - 16, y: particle.position.y - 16, width: 32, height: 32)), with: .color(.cyan))
                    }
                }
            }.gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        particleSystem.position = drag.location
                    }
            )
            .ignoresSafeArea()
        .background(.black)
        }.frame(height: 600)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding()
    }
}

#Preview {
    DrawingsView()
}
