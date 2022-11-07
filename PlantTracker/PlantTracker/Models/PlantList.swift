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
    
    //sorts the list of plants in order from least to most days until it needs to be watered
    func sort(){
        for index in 2...plantList.count {
            //should be days left to water not duration
            if(plantList[index].duration < plantList[index - 1].duration){
                //swap
                let tempPlant = plantList[index]
                plantList[index] = plantList[index - 1]
                plantList[index - 1] = tempPlant
            }
        }
    }
    
    init(){
        plantList = []
        for dataItem in dataList {
            if let dur = Double(dataItem.DaysBetweenWatering) {
                let plantItem = Plant(plantName: dataItem.plantName, daysBtWatering: dur, lastWatered: Date())
                addPlant(plantToAdd: plantItem)
            }
        }
        sort()
    }
    
    func getListOfPlants() -> [Plant]{
        return plantList
    }
}
