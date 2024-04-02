//
//  ObservationFrameworkView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da Cruz on 07/02/2024.
//

import SwiftUI
import Observation

@Observable class FoodTruckModel {
    var orders: [String] = []
    var donuts: [String] = []
    
    func addDonut() {
        donuts.append("Test Donut")
    }
}

struct ObservationFrameworkView: View {
    let model = FoodTruckModel()
    var body: some View {
        List {
          Section("Donuts") {
              ForEach(model.donuts, id: \.self) { donut in
              Text(donut)
            }
            Button("Add new donut") {
              model.addDonut()
            }
          }
        }
    }
}

#Preview {
    ObservationFrameworkView()
}
