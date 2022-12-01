//
//  Plant.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import Foundation

class Plant : Identifiable, ObservableObject {
    let id = UUID()
    @Published var now: Date = Date() //current Date
    @Published var name: String //name of plant
    @Published var duration: Double //time (days) between watering
    @Published var dateLastWatered: Date //date last watered
    
    //static var all: [Plant] = PlantList().plantList

    //dateLastWatered + duration = new date
    //days from today till new date
    var daysBeforeWatering: Double {
        let durationToSec = daysToSeconds(time: duration)
        let whenToWater = dateLastWatered.addingTimeInterval(durationToSec)
        let timeBeforeWater = now.timeIntervalSince(whenToWater)
        return secondsToDays(time: timeBeforeWater)
    }
    
    var isReadyToWater: Bool {
        return daysBeforeWatering == 0
    }
    
    //convert from TimeInterval to # days
    func secondsToDays(time: TimeInterval) -> Double {
        let toMinutes = time/60
        let toHours = toMinutes/60
        let toDays = toHours/24
        return ceil(toDays)
    }
    
    //convert from # days to seconds
    func daysToSeconds(time: Double) -> TimeInterval {
        let toHours = time * 24
        let toMin = toHours * 60
        let toSec = toMin * 60
        return TimeInterval(toSec)
    }
    
    var timeUntilWater : Double{
        if let targetDate = Calendar.current.date(byAdding: .day, value: Int(duration), to: dateLastWatered) {
            let secondsToTarget = now.distance(to: targetDate)
            return secondsToDays(time: secondsToTarget)
        }
        return 1.0
    }
    
    //initializer:
    //Params: plantName (name of plant), daysBtWatering (days until it needs to be watered)
    //lastWatered: date plant was last watered
    init(plantName: String, daysBtWatering: Double, lastWatered: Date){
        name = plantName
        duration = daysBtWatering
        dateLastWatered = lastWatered
    }
}
