//
//  plantData.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 10/2/22.
//

import Foundation

//Gets info from JSON as strings -> gets converted to Plant objects 
struct PlantData: Codable {
    var id: String
    var plantName: String
    var DateLastWatered: String
    var DaysBetweenWatering: String
    var notes: String

    static func fromJSON(file: FileHandle) -> [PlantData] {
        let decoder = JSONDecoder()
        do {
            let plantList = try decoder.decode([PlantData].self, from: file.availableData)
            return plantList
        } catch {
            print("Could not make plant from data.", error.localizedDescription)
        }
        return []
    }
    
    init(id: String, plantName: String, DateLastWatered: String, DaysBetweenWatering: String, notes: String) {
        self.id = id
        self.plantName = plantName
        self.DateLastWatered = DateLastWatered
        self.DaysBetweenWatering = DaysBetweenWatering
        self.notes = notes
    }
}
