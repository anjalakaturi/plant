//
//  ContentView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var plantObject : PlantList 
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    @State private var isPresentingAddView = false
    @State private var isPresentingUpdateView = false
    @State private var newPlantData = Plant(plantName: "", daysBtWatering: 1.0, lastWatered: Date(), notes: "")
    @State private var tempPlantData = Plant(plantName: "", daysBtWatering: 1.0, lastWatered: Date(), notes: "")
    @State private var emptyPlantData = Plant(plantName: "", daysBtWatering: 1.0, lastWatered: Date(), notes: "")
    @State private var updateIndex = 0
    
    var body: some View {
        VStack{
            Text("Your Plants")
                .font(.largeTitle)
            List{
                if(plantObject.plantList.count == 0){
                    HStack{
                        Text("Hit the + button to start tracking your plants")
                    }
                }
                ForEach(plantObject.plantList) { plant in
                    HStack {
                        Button(action: {
                            isPresentingUpdateView = true
                            tempPlantData.name = plant.name
                            tempPlantData.duration = plant.duration
                            tempPlantData.dateLastWatered = plant.dateLastWatered
                            updateIndex = plantObject.getPlantIndex(plantToFind: plant)
                        }) {
                            Image(systemName: "pencil.circle")
                                .font(.system(size: 40))
                                .cornerRadius(40)
                                .foregroundColor(Color.black)
                        }
                        .accessibilityLabel("Update Plant")
                        .buttonStyle(BorderlessButtonStyle())
                        Spacer()
                        VStack{
                            Text("\(plant.name)")
                                .fontWeight(.bold)
                                .font(.title2)
                            HStack{
                                if(plant.timeUntilWater == 1.0){
                                    Text("Water in: " + "\(Int(plant.timeUntilWater))" + " day")
                                }
                                else if(plant.timeUntilWater == 0.0){
                                    Text("Water today")
                                }
                                else if(plant.timeUntilWater < 0.0){
                                    Text("Needed water " + "\(Int(plant.timeUntilWater) * -1)" + " days ago")
                                }
                                else{
                                    Text("Water in: " + "\(Int(plant.timeUntilWater))" + " days")
                                }
                            }
                        }
                        Spacer()
                        Button(action: {
                            plantObject.updateDateLastWatered(plantWatered: plant)
                        }) {
                            Image(systemName: "drop")
                                .font(.system(size: 30))
                                .padding(5)
                                .background(Color.blue)
                                .cornerRadius(40)
                                .foregroundColor(.white)
                                .padding(5)
                        }
                        .accessibilityLabel("Water Plant")
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .listRowBackground(getBackgroundColor(daysLeft: plant.timeUntilWater))
                }
            }
            .toolbar {
                Button(action:{
                    isPresentingAddView = true}) {
                        Image(systemName: "plus.circle")
                    }
                    .accessibilityLabel("Add Plant")
            }
            .sheet(isPresented: $isPresentingAddView) {
                NavigationView {
                    AddView(currentPlant: newPlantData, slider: SliderData(sliderValue: newPlantData.duration))
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    newPlantData.name = emptyPlantData.name
                                    newPlantData.duration = emptyPlantData.duration
                                    newPlantData.dateLastWatered = emptyPlantData.dateLastWatered
                                    newPlantData.notes = emptyPlantData.notes
                                    isPresentingAddView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    plantObject.addPlant(plantToAdd: newPlantData)
                                    newPlantData.name = emptyPlantData.name
                                    newPlantData.duration = emptyPlantData.duration
                                    newPlantData.dateLastWatered = emptyPlantData.dateLastWatered
                                    newPlantData.notes = emptyPlantData.notes
                                    isPresentingAddView = false
                                }
                            }
                        }
                }
            }
            .sheet(isPresented: $isPresentingUpdateView) {
                NavigationView {
                    UpdateView(currentPlant: tempPlantData, slider: SliderData(sliderValue: tempPlantData.duration))
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    tempPlantData.name = emptyPlantData.name
                                    tempPlantData.duration = emptyPlantData.duration
                                    tempPlantData.dateLastWatered = emptyPlantData.dateLastWatered
                                    tempPlantData.notes = emptyPlantData.notes
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
                                    tempPlantData.notes = emptyPlantData.notes
                                    isPresentingUpdateView = false
                                }
                            }
                            ToolbarItem(placement: .bottomBar) {
                                Button("Delete Plant") {
                                    //check all fields and make sure that they fit
                                    plantObject.deletePlant(plantToRemove: tempPlantData, index: updateIndex)
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
    
    func getBackgroundColor(daysLeft: Double) -> Color{
        if(daysLeft <= 0){
            return Color("needToWater")
        }
        else{
            return Color("happyPlant")
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
