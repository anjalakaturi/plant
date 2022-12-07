//
//  PlantTrackerApp.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 11/29/22.
//

import Foundation
import SwiftUI

@main
struct PlantTrackerApp: App {
    @StateObject private var listOfPlants = PlantList()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(plantObject: listOfPlants){
                    PlantList.save(plantList: listOfPlants.plantList) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                PlantList.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let plantList):
                        listOfPlants.plantList = plantList
                    }
                }
            }
        }
    }
}
