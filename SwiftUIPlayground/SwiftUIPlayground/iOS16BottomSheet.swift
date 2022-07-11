//
//  iOS16BottomSheet.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 11/07/2022.
//

import SwiftUI

struct iOS16BottomSheet: View {
    @State private var showingSheet = false
    
    @State private var presentationDetents: [Set<PresentationDetent>] = [[.medium, .large], [.fraction(0.6)], [.height(200)]]
    
    @State private var selectedDetentType = 0
    
    @State private var showDragIndicator = true

    var body: some View {
        VStack(spacing: 24) {
            Picker("Detents", selection: $selectedDetentType) {
                Text("Medium default").tag(0)
                Text("Fraction").tag(1)
                Text("Custom Height").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            Toggle("Show Drag Indicator ?", isOn: $showDragIndicator)
            switch (selectedDetentType) {
            case 1:
                Text("Fraction: 0.6")
            case 2:
                Text("Height: 200px")
            default:
                EmptyView()
            }
            Divider()
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                VStack(alignment: .center) {
                    Image("image-1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .cornerRadius(10)
                    Text("This is a photo taken in Roma, Italy in 2018 🇮🇹 🏟")
                        .multilineTextAlignment(.center)
                        
                }
                .padding()
                .presentationDetents(presentationDetents[selectedDetentType])
                .presentationDragIndicator(showDragIndicator ? .visible : .hidden)
        }
            Spacer()
        }
        .frame(minHeight: 0, idealHeight: .infinity, maxHeight: .infinity)
        .padding()
        .navigationTitle("iOS16 Bottom Sheet Playground")
    }
}

struct iOS16BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        iOS16BottomSheet()
    }
}
