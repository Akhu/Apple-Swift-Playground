//
//  BabyLevelGradient.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 25/07/2022.
//

import SwiftUI

struct BabyLevelGradient: View {
    let colors: [Color] = [.blue, .mint, .indigo, .green, .yellow, .orange, .red, .purple]
    @State private var shadowEnabled = false
    @State private var insetShadow = false
    var body: some View {
        List {
            Text("So making gradient is now so easy that even a baby can do it 👶")
                .foregroundColor(.secondary)
            Toggle("Shadow", isOn: $shadowEnabled)
            Toggle("Inset", isOn: $insetShadow).disabled(!shadowEnabled)
            ForEach(colors, id: \.self) { color in
                Group {
                    if shadowEnabled {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                insetShadow ? color.gradient.shadow(.inner(color: .black.opacity(0.2), radius: 6, y: 8)) : color.gradient.shadow(.drop(color: color.opacity(0.2), radius: 6, y: 8)))
                    } else {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(color.gradient)
                    }
                }
                .frame(height: 44)
                .padding(4)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Gradients and Shadows")
    }
}

struct BabyLevelGradient_Previews: PreviewProvider {
    static var previews: some View {
        BabyLevelGradient()
    }
}
