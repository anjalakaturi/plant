//
//  ContentView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import SwiftUI

struct ContentView: View {
    var plantList = PlantData.listOfPlants!
    var body: some View {
        VStack{
            ForEach(0..<5) { i in
                HStack {
                    Image(systemName: "leaf")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    //Spacer()
                    let testPlant = plantList[i]
                    //{
                    Text("\(testPlant.plantName)")
                    //                } else {
                    //                    Text("No person found.")
                    //                }
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
                    Text("\(testPlant.DaysBetweenWatering)")
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
