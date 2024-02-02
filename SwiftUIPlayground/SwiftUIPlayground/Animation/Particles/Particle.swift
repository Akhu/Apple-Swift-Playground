//
//  Particle.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 25/07/2022.
//

import Foundation
//Todo : https://www.youtube.com/watch?v=raR-hDgzoFg
struct Particle: Hashable {
    let x: Double
    let y: Double
    let creationDate = Date.now.timeIntervalSinceReferenceDate
}

class ParticleSnow {
    var x: Double
    var y: Double
    let xSpeed: Double
    let ySpeed: Double
    let deathDate = Date.now.timeIntervalSinceReferenceDate + 2

    init(x: Double, y: Double, xSpeed: Double, ySpeed: Double) {
        self.x = x
        self.y = y
        self.xSpeed = xSpeed
        self.ySpeed = ySpeed
    }
}
