//
//  AddView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/19/22.
//

import Foundation
import SwiftUI

struct AddView: View {
    @State var currentPlant: Plant
    @State private var isEditing = false
    @ObservedObject var slider : SliderData

    var body: some View {
        //https://developer.apple.com/tutorials/app-dev-training/creating-a-navigation-hierarchy
        VStack{
        List {
            Section(header: Text("Enter Plant Information")) {
                HStack {
                    Image(systemName: "leaf")
                        .foregroundColor(.accentColor)
                    Spacer()
                    TextField("Plant Name", text: $currentPlant.name)}
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.accentColor)
                    Spacer()
                    VStack {
                        Slider(
                            value: $slider.sliderValue,
                            in: 1...60,
                            step: 1
                        ) {
                            Text("Watering Frequency")
                        } minimumValueLabel: {
                            Text("1")
                        } maximumValueLabel: {
                            Text("60")
                        } onEditingChanged: { editing in
                            isEditing = editing
                            currentPlant.duration = slider.sliderValue
                        }
                        if(slider.sliderValue == 1.0){
                            Text(String(Int(slider.sliderValue)) + " Day In Between Watering")
                                .foregroundColor(isEditing ? .red : .black)
                        }
                        else{
                            Text(String(Int(slider.sliderValue)) + " Days In Between Watering")
                                .foregroundColor(isEditing ? .red : .black)
                        }
                    }
                }
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.accentColor)
                    Spacer()
                    DatePicker(
                            "Date Last Watered",
                            selection: $currentPlant.dateLastWatered,
                            in: ...Date(),
                            displayedComponents: [.date]
                        )
                }
                HStack{
                    Image(systemName: "list.clipboard")
                        .foregroundColor(.accentColor)
                    Spacer()
                    TextField("Notes", text: $currentPlant.notes)
                }
                .accessibilityElement(children: .combine)
            }
        }
        .navigationTitle("Add New Plant")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView(currentPlant: Plant(plantName: "", daysBtWatering: 2.0, lastWatered: Date(), notes: ""), slider: SliderData(sliderValue: 1.0))
        }
    }
}

