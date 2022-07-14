//
//  GridView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 14/07/2022.
//  From Hacking With Swift
//

import SwiftUI

struct GridView: View {
    

    
    @State private var selectedView = 0
    
    var body: some View {
        VStack(spacing: 24) {
            Picker("Grid Sample", selection: $selectedView) {
                Text("Dynamic grid").tag(0)
                Text("Tic Tac Toe").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            
            switch (selectedView) {
            case 0:
                GridViewScoreView()
            case 1:
                TicTacToeGridView()
            default:
                EmptyView()
            }
            Spacer()
        }.navigationTitle(Text("Grid View"))
    }
}

struct TicTacToeGridView: View {
    var body: some View {
        Grid(horizontalSpacing: 20, verticalSpacing: 20) {
            GridRow {
                Image(systemName: "xmark")
                Image(systemName: "xmark")
                Image(systemName: "xmark")
            }
            GridRow {
                Image(systemName: "circle")
                Image(systemName: "xmark")
                Image(systemName: "circle")
            }
            GridRow {
                Image(systemName: "xmark")
                Image(systemName: "circle")
                Image(systemName: "circle")
            }
        }
    }
}

struct GridViewScoreView: View {
    @State private var redScore = 0
    @State private var blueScore = 0
    var body: some View {
        Grid {
            GridRow {
                Text("Score")
                    .font(.headline)
            }.gridCellColumns(2)
                .multilineTextAlignment(.leading)
            
            GridRow {
                Text("Red")
                
                ForEach(0..<redScore, id: \.self) { _ in
                    Rectangle()
                        .fill(.red)
                        .frame(width: 20, height: 20)
                }
            }
            
            GridRow {
                Text("Blue")
                ForEach(0..<blueScore, id: \.self) { _ in
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 20, height: 20)
                }
            }
            
            
            
            Button("Red Scored") { redScore += 1}.buttonStyle(BorderedButtonStyle())
            Button("Blue Scored") { blueScore += 1}
                .foregroundColor(.blue)
                .buttonStyle(BorderedButtonStyle())
            
        }.navigationTitle(Text("Grid View"))
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
