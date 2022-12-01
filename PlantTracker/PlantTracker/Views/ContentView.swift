//
//  ContentView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var plantObject : PlantList = PlantList()
    @State private var isPresentingAddView = false
    @State private var isPresentingUpdateView = false
    @State private var newPlantData = Plant(plantName: "temp", daysBtWatering: 2.0, lastWatered: Date())
    
    var body: some View {
        List{
            ForEach(plantObject.plantList) { plant in
                HStack {
                    Button(action: {
                        isPresentingUpdateView = true
                    }) {
                        //Text("WATER")
                        Image(systemName: "pencil.circle")
                            //.fontWeight(.bold)
                            .font(.system(size: 40))
                            //.padding(5)
                            //.background(Color.blue)
                            .cornerRadius(40)
                            .foregroundColor(Color.blue)
                            //.padding()
                    }
                    .accessibilityLabel("Update Plant")
                    .buttonStyle(BorderlessButtonStyle())
                    //.padding()
                    Spacer()
                VStack{
                        Text("\(plant.name)")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        //Spacer()
                        HStack{
                            Text("Days Until Watering")
                            Text("\(Int(plant.timeUntilWater))")
                        }
                    }
                    Spacer()
                    Button(action: {
                        plantObject.updateDateLastWatered(plantWatered: plant)
                    }) {
                        //Text("WATER")
                        Image(systemName: "drop")
                            //.fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding(5)
                            .background(Color.blue)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                            .padding(5)
                    }
                    //.padding()
                    .accessibilityLabel("Water Plant")
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .toolbar {
            Button(action:{
                isPresentingAddView = true}) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add Plant")
                }
        .sheet(isPresented: $isPresentingAddView) {
            NavigationView {
                AddView(currentPlant: newPlantData)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Dismiss") {
                                            isPresentingAddView = false
                                        }
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Add") {
                                            //check all fields and make sure that they fit
                                            //save new plant/add to list
                                            plantObject.addPlant(plantToAdd: newPlantData)
                                            isPresentingAddView = false
                                        }
                                    }
                                }
                        }
                }
        .sheet(isPresented: $isPresentingUpdateView) {
            NavigationView {
                UpdateView(currentPlant: newPlantData)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Dismiss") {
                                            isPresentingUpdateView = false
                                        }
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Update") {
                                            //check all fields and make sure that they fit
                                            //save new plant/add to list
                                            isPresentingUpdateView = false
                                        }
                                    }
                                }
                        }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
