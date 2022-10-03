//
//  plantData.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 10/2/22.
//

import Foundation

struct PlantData: Codable {
    var name: String
    //var dateWatered: String
    //var daysBtWater: String
    
    static var p0: PlantData? {
        PlantData.fromJSON(named: "plantFile")
    }

    static func fromJSON(named name: String) -> PlantData? {
        //return
        if let data = Data.fromJSONFile(forName: name) {
            let decoder = JSONDecoder()
            do {
                let luke = try decoder.decode(PlantData.self, from: data)
                return luke
            } catch {
                print("Could not make person from data.", error.localizedDescription)
            }
        }
        return nil
    }
}
