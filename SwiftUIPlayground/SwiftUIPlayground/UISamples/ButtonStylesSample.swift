//
//  ButtonStylesSample.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 08/07/2023.
//

import SwiftUI

extension View {
    func buttonPadding() -> some View {
        self
            .padding(.vertical, 18)
            .padding(.horizontal, 18)
    }
}
let buttonShape = RoundedRectangle(cornerRadius: 9.0, style: .continuous)

struct FlatButtonStyle: ButtonStyle {
    var color: Color = Color.blue
    var textColor: Color = Color.white
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration
            .label
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(textColor)
            .buttonPadding()
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? buttonShape.fill(color.opacity(1)) : buttonShape
                            .fill(color)
            )
            .overlay(
                buttonShape.stroke(color.opacity(0.4), lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
            .rotation3DEffect(
                .degrees(configuration.isPressed ? 3: 0),
                axis: (x: -5.0, y: 0.0, z: 0.0))
            .shadow(color: configuration.isPressed ? Color.black.opacity(0.1) : Color.black.opacity(0.06), radius: configuration.isPressed ? 2 : 4, x: 0, y: 2)
        
    }
}

struct FlatButtonStyleNoShadow: ButtonStyle {
    var color: Color = Color.red
    var textColor: Color = Color.white
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(textColor)
            .buttonPadding()
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? buttonShape.fill(color.opacity(1)) : buttonShape
                            .fill(color)
            )
            .overlay(
                buttonShape.stroke(color.opacity(0.4), lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
            .rotation3DEffect(
                .degrees(configuration.isPressed ? 3: 0),
                axis: (x: -5.0, y: 0.0, z: 0.0))
            
        
    }
}




struct OutlineButtonStyle: ButtonStyle {
    
    var textColor: Color = Color.white
    var color: Color = Color.indigo
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(color)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .overlay(configuration.isPressed ? buttonShape.stroke(color.opacity(0.1), lineWidth: 2) : buttonShape.stroke(color.opacity(1), lineWidth: 2))
    }
    
}


struct SimpleAnimatedButtonStyle: ButtonStyle {
    
    var color: Color = Color.indigo
    
    var displayStroke : Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        if displayStroke {
            configuration
                .label
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                .opacity(configuration.isPressed ? 0.7 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
                .rotation3DEffect(
                    .degrees(configuration.isPressed ? 3: 0),
                    axis: (x: -5.0, y: 0.0, z: 0.0))
                .overlay(configuration.isPressed ? buttonShape.stroke(color.opacity(0.1), lineWidth: 2) : buttonShape.stroke(color.opacity(0.5), lineWidth: 2))
        } else {
            configuration
                .label
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                .opacity(configuration.isPressed ? 0.7 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
                .rotation3DEffect(
                    .degrees(configuration.isPressed ? 3: 0),
                    axis: (x: -5.0, y: 0.0, z: 0.0))
        }
    }
    
}


struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack(spacing: 20) {
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "hand.raised")
                    Text("Hello Button")
                }
            }).buttonStyle(OutlineButtonStyle())
            
            Button(action: {}, label: {
                HStack {
                    Group {
                        Image(systemName: "xmark.circle")
                        Text("Close")
                    }.font(.system(size: 18, weight: .bold, design: .default))
                }
            }).buttonStyle(FlatButtonStyle(color: Color.indigo, textColor: Color.white))
            Button(action: {}, label: {
                HStack {
                    Group {
                        Image(systemName: "xmark.circle")
                        Text("Close")
                    }.font(.system(size: 18, weight: .bold, design: .default))
                }
            }).buttonStyle(SimpleAnimatedButtonStyle())
        }
    }
}

