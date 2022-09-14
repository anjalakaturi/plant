//
//  plantRow.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import SwiftUI
import Foundation

struct PlantRow: View {
    var plant: Plant

    var body: some View {
        HStack {
                    Text(plant.name)
                    
                    Spacer()
            Text("WATER")
                .fontWeight(.bold)
                .font(.body)
                .padding()
                .background(Color.green)
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(10)
                .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.green, lineWidth: 5)
                    )
                }
    }
}

struct PlantRow_Previews: PreviewProvider {
    static var previews: some View {
        PlantRow(plant: Plant(plantName: "plant1", daysBtWatering: 7.0, lastWatered: Date()))
        
    }
}
