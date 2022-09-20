//
//  PlantList.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import Foundation

class PlantList {
    var list: [Plant]
    
    func addPlant(plantToAdd: Plant){
        list.append(plantToAdd)
    }
    
    //sorts the list of plants in order from least to most days until it needs to be watered
    func sort(){
        for index in 2...list.count {
            if(list[index].daysLeft < list[index - 1].daysLeft){
                //swap
                let tempPlant = list[index]
                list[index] = list[index - 1]
                list[index - 1] = tempPlant
            }
        }
    }
    
    init(){
        list = []
    }
}
