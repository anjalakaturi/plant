//
//  Plant.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import Foundation

struct Plant {
    var now: Date = Date() //current Date
    var name: String //name of plant
    var duration: TimeInterval //time (days) between watering
    var dateLastWatered: Date //date last watered
    var daysLeft: TimeInterval //time (days) until plant needs to be watered
    var isReadyToWater: Bool
    
    //dateLastWatered + duration = new date
    //days from today till new date
    var daysBeforeWatering: Int64 {
        1
        //dateLastWatered.distance()
    }
    
    //initializer:
    //Params: plantName (name of plant), daysBtWatering (days until it needs to be watered)
    //lastWatered: date plant was last watered
    init(plantName: String, daysBtWatering: TimeInterval, lastWatered: Date){
        name = plantName
        duration = daysBtWatering
        dateLastWatered = lastWatered
        daysLeft = now.timeIntervalSince(dateLastWatered)
        isReadyToWater = false;
    }
}
