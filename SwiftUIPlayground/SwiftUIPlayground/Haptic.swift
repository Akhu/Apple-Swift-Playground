//
//  Haptic.swift
//  Haptic
//
//  Created by Anthony Da cruz on 29/08/2021.
//

import SwiftUI
import CoreHaptics

struct Haptic: View {
    @State var sharpnessFloat: Float = 0
    @State var intensityFloat: Float = 0
    @State var hapticEngine: CHHapticEngine?
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Sharpness \(sharpnessFloat)")
                    Slider(value: $sharpnessFloat, in: 0...1)
                }
                Section {
                    Text("Intensity \(intensityFloat)")
                    Slider(value: $intensityFloat, in: 0...1)
                }
                
                Section {
                    Button {
                    hapticTest(intensity: intensityFloat, sharpness: sharpnessFloat)
                    } label: {
                        Text("Test Haptic")
                    }.onAppear(perform: prepareHaptics)
                }
            }.navigationTitle("Haptic Playground")
        }
        

    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Error when creating engine \(error.localizedDescription)")
        }
    }
    
    func hapticTest(intensity: Float, sharpness: Float){
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct Haptic_Previews: PreviewProvider {
    static var previews: some View {
        Haptic()
    }
}
