//
//  ContentView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var plantObject : PlantList //= PlantList()
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    @State private var isPresentingAddView = false
    @State private var isPresentingUpdateView = false
    @State private var newPlantData = Plant(plantName: "", daysBtWatering: 0.0, lastWatered: Date())
    @State private var tempPlantData = Plant(plantName: "", daysBtWatering: 0.0, lastWatered: Date())
    @State private var emptyPlantData = Plant(plantName: "", daysBtWatering: 0.0, lastWatered: Date())
    @State private var updateIndex = 0
    
    var body: some View {
        List{
            ForEach(plantObject.plantList) { plant in
                HStack {
                    Button(action: {
                        isPresentingUpdateView = true
                        tempPlantData.name = plant.name
                        tempPlantData.duration = plant.duration
                        tempPlantData.dateLastWatered = plant.dateLastWatered
                        updateIndex = plantObject.getPlantIndex(plantToFind: plant)
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
                            Text("Days Until Watering:")
                            Text("\(Int(plant.timeUntilWater))")
                        }
                    }
                    Spacer()
                    Button(action: {
                        plantObject.updateDateLastWatered(plantWatered: plant)
                    }) {
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
                                            newPlantData.name = emptyPlantData.name
                                            newPlantData.duration = emptyPlantData.duration
                                            newPlantData.dateLastWatered = emptyPlantData.dateLastWatered
                                            isPresentingAddView = false
                                        }
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Add") {
                                            //check all fields and make sure that they fit
                                            //save new plant/add to list
                                            plantObject.addPlant(plantToAdd: newPlantData)
                                            newPlantData.name = emptyPlantData.name
                                            newPlantData.duration = emptyPlantData.duration
                                            newPlantData.dateLastWatered = emptyPlantData.dateLastWatered
                                            isPresentingAddView = false
                                        }
                                    }
                                }
                        }
                }
        .sheet(isPresented: $isPresentingUpdateView) {
            NavigationView {
                UpdateView(currentPlant: tempPlantData)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Dismiss") {
                                            tempPlantData.name = emptyPlantData.name
                                            tempPlantData.duration = emptyPlantData.duration
                                            tempPlantData.dateLastWatered = emptyPlantData.dateLastWatered
                                            isPresentingUpdateView = false
                                        }
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Update") {
                                            //check all fields and make sure that they fit
                                            plantObject.updateInformation(updatedPlant: tempPlantData, index: updateIndex)
                                            tempPlantData.name = emptyPlantData.name
                                            tempPlantData.duration = emptyPlantData.duration
                                            tempPlantData.dateLastWatered = emptyPlantData.dateLastWatered
                                            isPresentingUpdateView = false
                                        }
                                    }
                                }
                        }
                }
        .onChange(of: scenePhase) { phase in
                    if phase == .inactive { saveAction() }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(plantObject: PlantList(), saveAction: {(()->Void).self})
        }
    }
}
