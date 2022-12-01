//
//  UpdateView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/19/22.
//

import Foundation
import SwiftUI

struct UpdateView: View {
    @State var currentPlant: Plant
    @State private var isEditing = false
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
                            value: $currentPlant.duration,
                            in: 0...60,
                            step: 1
                        ) {
                            Text("Speed")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("60")
                        } onEditingChanged: { editing in
                            isEditing = editing
                        }
                        Text("\(Int(currentPlant.duration)) Days In Between Watering")
                            .foregroundColor(isEditing ? .red : .blue)
                    }
                }
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.accentColor)
                    //Label("Date Last Watered", systemImage: "calendar")
                    Spacer()
                    DatePicker(
                            "Date Last Watered",
                            selection: $currentPlant.dateLastWatered,
                            displayedComponents: [.date]
                        )
                }
//                HStack {
//                    Label("Notes", systemImage: "pencil")
//                    Spacer()
//                    Text("")
//                }
                .accessibilityElement(children: .combine)
            }
            //.collapsible(false)
        }
        .navigationTitle("Update Plant Info")
        }
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UpdateView(currentPlant: Plant(plantName: "", daysBtWatering: 2.0, lastWatered: Date()))
        }
    }
}

