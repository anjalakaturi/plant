//
//  ContentView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import SwiftUI

struct ContentView: View {
    var plantlist : [Plant] = PlantList().getListOfPlants()
    var body: some View {
        VStack{
            ForEach(0..<5) { i in
                HStack {
                    Image(systemName: "leaf")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    let testPlant = plantlist[i]
                    Text("\(testPlant.name)")
                    Button(action: {
                        print("watering plants")
                    }) {
                        Text("WATER")
                            .fontWeight(.bold)
                            .font(.body)
                            .padding(5)
                            .background(Color.blue)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.blue, lineWidth: 4)
                            )
                    }
                    Text("\(Int(testPlant.calcTimeUntilWater()))")
                    //Text("\(testPlant.dateLastWatered)")
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
