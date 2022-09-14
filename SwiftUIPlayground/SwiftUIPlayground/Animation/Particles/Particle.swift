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
