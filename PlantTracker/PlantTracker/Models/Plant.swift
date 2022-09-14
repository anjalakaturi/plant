//
//  Plant.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import Foundation

class Plant {
    var now: Date = Date()
    var name: String
    var duration: TimeInterval
    var dateLastWatered: Date
    var daysLeft: TimeInterval
    
    var daysBeforeWatering: Int64 {
        1
        //dateLastWatered.distance()
    }
    
    init(plantName: String, daysBtWatering: TimeInterval, lastWatered: Date){
        name = plantName
        duration = daysBtWatering
        dateLastWatered = lastWatered
        daysLeft = now.timeIntervalSince(dateLastWatered)
    }
}
