//
//  plantData.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 10/2/22.
//

import Foundation

struct PlantData: Codable {
    var id: String
    var plantName: String
    var DateLastWatered: String
    var DaysBetweenWatering: String
    //var plantType: String
    
//    static func listOfPlants(named: String) -> [PlantData] {
//        return PlantData.fromJSON(named: "plantInfo")
//    }

    //static func fromJSON(named name: String) -> [PlantData] {
    static func fromJSON(file: FileHandle) -> [PlantData] {
        //if let data = Data.fromJSONFile(forName: name) {
            let decoder = JSONDecoder()
            do {
                //let plantList = try decoder.decode([PlantData].self, from: data)
                let plantList = try decoder.decode([PlantData].self, from: file.availableData)
                return plantList
            } catch {
                print("Could not make plant from data.", error.localizedDescription)
            }
        //}
        return []
    }
    
    //TODO: if update fails, how to handle -> crash? assert error?
    static func updateJSON(){
        
    }
    
    static func deletePlantFromJSON(){
        //listOfPlants!.remove(at: 0)
    }
    
    init(id: String, plantName: String, DateLastWatered: String, DaysBetweenWatering: String) {
        self.id = id
        self.plantName = plantName
        self.DateLastWatered = DateLastWatered
        self.DaysBetweenWatering = DaysBetweenWatering
    }
}
