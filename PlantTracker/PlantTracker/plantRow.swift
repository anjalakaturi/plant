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
            Spacer()
            Text(plant.name)
                .font(.largeTitle)
            
            Spacer()
            Button(action: {
                print("watering plants")
            }) {
                Image(systemName: "drop")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.body)
                    .padding(8.0)
                    .background(Color.blue)
                    .cornerRadius(30)
                    .foregroundColor(.white)
                    .padding(5)
            }
            Spacer()
        }
        .background(Color.gray)
        .cornerRadius(30)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.green, lineWidth: 5)
        )
    }
}

struct PlantRow_Previews: PreviewProvider {
    static var previews: some View {
        PlantRow(plant: Plant(plantName: "Plant Name", daysBtWatering: 7.0, lastWatered: Date()))
        
    }
}
