//
//  SettingsView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 12/5/22.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @State var currentPlant: Plant
    @State private var isEditing = false
    var body: some View {
        //https://developer.apple.com/tutorials/app-dev-training/creating-a-navigation-hierarchy
        VStack{
        List {
            Section(header: Text("Enter Plant Information")) {
                HStack {
                    Label("Happy Plant", systemImage: "paintpalette")
                    Spacer()
                    Text("scrum.theme.name")
                        .padding(4)
                        //.foregroundColor(.accentColor)
                    //.background(.accentColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
        }
        .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(currentPlant: Plant(plantName: "", daysBtWatering: 2.0, lastWatered: Date(), notes: ""))
        }
    }
}


