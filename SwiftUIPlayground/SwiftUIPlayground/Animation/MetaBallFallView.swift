//
//  SnowFallView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da Cruz on 02/02/2024.
//

import SwiftUI

class SnowFallParticleSystem {
    var particles = [ParticleSnow]()
    var lastUpdate = Date.now.timeIntervalSinceReferenceDate
    
    func update(date: TimeInterval, size: CGSize) {
        let delta = date - lastUpdate
        lastUpdate = date

        for (index, particle) in particles.enumerated() {
            if particle.deathDate < date {
                particles.remove(at: index)
            } else {
                particle.x += particle.xSpeed * delta
                particle.y += particle.ySpeed * delta
            }
        }
            
        let newParticle = ParticleSnow(x: .random(in: -32...size.width), y: -32, xSpeed: .random(in: -50...50), ySpeed: .random(in: 100...500))
        particles.append(newParticle)
    }
}

struct MetaBallFallView: View {
    @State private var particleSystem = SnowFallParticleSystem()
    
    @State var blurAmount: CGFloat = 5.0
    
    @State var topColor: Color = .green
    @State var centerColor: Color = .indigo
    @State var bottomColor: Color = .red
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                ColorPicker("Top Color", selection: $topColor)
                ColorPicker("Center Color", selection: $centerColor)
                ColorPicker("Bottom Color", selection: $bottomColor)
                VStack(alignment: .leading) {
                    Text("Metaball effect")
                    Slider(value: $blurAmount, in: 0...10)
                }.fontWeight(.heavy)
                LinearGradient(colors: [topColor, centerColor, bottomColor], startPoint: .top, endPoint: .bottom).mask {
                    // current TimelineView code
                
                TimelineView(.animation) { timeline in
                    Canvas { ctx, size in
                        let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                        particleSystem.update(date: timelineDate, size: size)
                        ctx.addFilter(.alphaThreshold(min: 0.5, color: .white))
                        ctx.addFilter(.blur(radius: blurAmount))

                        ctx.drawLayer { ctx in
                            for particle in particleSystem.particles {
                                ctx.opacity = particle.deathDate - timelineDate
                                ctx.fill(Circle().path(in: CGRect(x: particle.x, y: particle.y, width: 32, height: 32)), with: .color(.white))
                                }
                            }
                        }
                    }
                }
                .ignoresSafeArea()
                .background(.black)
                .frame(height: 600)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(radius: 10)
                
            }.padding()
        }
        
    }
    
   
}

#Preview {
    MetaBallFallView()
}
