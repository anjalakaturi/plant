//
//  PlantList.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import Foundation

class PlantList {
    var dataList: [PlantData] = PlantData.listOfPlants!
    
    var plantList: [Plant]
    
    func addPlant(plantToAdd: Plant){
        plantList.append(plantToAdd)
    }
    
    init(){
        plantList = []
        //https://cocoacasts.com/swift-fundamentals-how-to-convert-a-string-to-a-date-in-swift
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        for dataItem in dataList {
            if let dur = Double(dataItem.DaysBetweenWatering) {
                if dateFormatter.date(from: dataItem.DateLastWatered) != nil {
                    print(dateFormatter.date(from: dataItem.DateLastWatered) as Any)
                    let plantItem = Plant(plantName: dataItem.plantName, daysBtWatering: dur, lastWatered: dateFormatter.date(from: dataItem.DateLastWatered)!)
                    addPlant(plantToAdd: plantItem)
                }
                else{
                    let plantItem = Plant(plantName: "Example Plant", daysBtWatering: dur, lastWatered: Date())
                    addPlant(plantToAdd: plantItem)
                }
            }
        }
    }
    
    func getListOfPlants() -> [Plant]{
        let sortedPlants = plantList.sorted {
            $0.calcTimeUntilWater() < $1.calcTimeUntilWater()
        }
        return sortedPlants
    }
}
