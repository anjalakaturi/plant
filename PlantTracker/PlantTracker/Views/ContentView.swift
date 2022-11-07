//
//  ContentView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import SwiftUI

struct ContentView: View {
    var list : [Plant] = PlantList().getListOfPlants()
    //var plantList = PlantData.listOfPlants!
    var body: some View {
        VStack{
            ForEach(0..<5) { i in
                HStack {
                    Image(systemName: "leaf")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    let testPlant = list[i]
                    //let testPlant = plantList[i]
                    Text("\(testPlant.name)")
                    //Text("\(testPlant.plantName)")
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
                    Text("\(testPlant.duration)")
                    //Text("\(testPlant.DaysBetweenWatering)")
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
