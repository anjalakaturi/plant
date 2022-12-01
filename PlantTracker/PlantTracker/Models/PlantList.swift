//
//  PlantList.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import Foundation

class PlantList : ObservableObject {
    var dataList: [PlantData] = PlantData.listOfPlants!
    
    @Published var plantList = [Plant]() 
    
    func addPlant(plantToAdd: Plant){
        plantList.append(plantToAdd)
        plantList = SortedPlants()
    }
    
    func deletePlant(plantToRemove : Plant){
        //https://stackoverflow.com/questions/24028860/how-to-find-index-of-list-item-in-swift
        let indexToRemove = plantList.firstIndex{$0 === plantToRemove}
        plantList.remove(at: indexToRemove!)
        plantList = SortedPlants()
    }
    
    func updateDateLastWatered(plantWatered : Plant){
        let plantIndex = plantList.firstIndex{$0 === plantWatered}
        plantList[plantIndex!].dateLastWatered = Date()
        plantList = SortedPlants()
        //TODO: call something to save in json
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
    
    private func SortedPlants() -> [Plant]{
        let sortedPlants = plantList.sorted {
            $0.timeUntilWater < $1.timeUntilWater
        }
        return sortedPlants
    }
}
