//
//  PlantList.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import Foundation

class PlantList : ObservableObject {
    //var dataList: [PlantData] = PlantData.listOfPlants!
    
    @Published var plantList = [Plant]() 
    
    func addPlant(plantToAdd: Plant){
        let newPlant = Plant(plantName: plantToAdd.name, daysBtWatering: plantToAdd.duration, lastWatered: plantToAdd.dateLastWatered, notes: plantToAdd.notes)
        plantList.append(newPlant)
        plantList = SortedPlants()
    }
    
    func deletePlant(plantToRemove : Plant, index: Int){
        plantList.remove(at: index)
        plantList = SortedPlants()
    }
    
    func updateDateLastWatered(plantWatered : Plant){
        let plantIndex = plantList.firstIndex{$0 === plantWatered}
        plantList[plantIndex!].dateLastWatered = Date()
        plantList = SortedPlants()
        //TODO: call something to save in json
    }
    
    func updateInformation(updatedPlant : Plant, index: Int){
        //let plantIndex = plantList.firstIndex{$0.name == updatedPlant.name}
//        if(plantIndex == -1){
//            return
//        }
        //TODO: should make a function in plant that updates it
        plantList[index].name = updatedPlant.name
        plantList[index].duration = updatedPlant.duration
        plantList[index].dateLastWatered = updatedPlant.dateLastWatered
        plantList = SortedPlants()
    }
    
    func getPlantIndex(plantToFind : Plant) -> Int{
        //https://stackoverflow.com/questions/24028860/how-to-find-index-of-list-item-in-swift
        let plantIndex = plantList.firstIndex{$0 === plantToFind}
        return plantIndex!
    }
    
    init(){
        
    }
    
    private func SortedPlants() -> [Plant]{
        if (plantList.count) <= 1 {
            return plantList
        }
        let sortedPlants = plantList.sorted {
            $0.timeUntilWater < $1.timeUntilWater
        }
        return sortedPlants
    }
    
    private static func fileURL() throws -> URL {
            try FileManager.default.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: false)
                .appendingPathComponent("plantInfo.json")
        }
    
    static func load(completion: @escaping (Result<[Plant], Error>)->Void) {
            DispatchQueue.global(qos: .background).async {
                do {
                    let fileURL = try fileURL()
                    guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                        DispatchQueue.main.async {
                            completion(.success([]))
                        }
                        return
                    }
                    //let dailyScrums = [Plant]()//try JSONDecoder().decode([Plant].self, from: file.availableData)
                    var plantListConstructor = [Plant]()
                    //https://cocoacasts.com/swift-fundamentals-how-to-convert-a-string-to-a-date-in-swift
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    let datalist = PlantData.fromJSON(file: file)
                    for dataItem in datalist {
                        if let dur = Double(dataItem.DaysBetweenWatering) {
                            if dateFormatter.date(from: dataItem.DateLastWatered) != nil {
                                print(dateFormatter.date(from: dataItem.DateLastWatered) as Any)
                                let plantItem = Plant(plantName: dataItem.plantName, daysBtWatering: dur, lastWatered: dateFormatter.date(from: dataItem.DateLastWatered)!, notes: dataItem.notes)
                                plantListConstructor.append(plantItem)
                            }
                            else{
                                let plantItem = Plant(plantName: "Example Plant", daysBtWatering: dur, lastWatered: Date(), notes: "")
                                plantListConstructor.append(plantItem)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        completion(.success(plantListConstructor))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    
    static func save(plantList: [Plant], completion: @escaping (Result<Int, Error>)->Void) {
            DispatchQueue.global(qos: .background).async {
                do {
                    var plantListString = [PlantData]()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    for p in plantList{
                        //plantListString.append(PlantData(id: String(p.id), plantName: p.name, DateLastWatered: String(p.dateLastWatered), DaysBetweenWatering: String(p.duration)))
                        plantListString.append(PlantData(id: p.id.uuidString, plantName: p.name, DateLastWatered: dateFormatter.string(from: p.dateLastWatered), DaysBetweenWatering: String(p.duration), notes: p.notes))
                    }
                    let data = try JSONEncoder().encode(plantListString)
                    let outfile = try fileURL()
                    try data.write(to: outfile)
                    DispatchQueue.main.async {
                        completion(.success(plantList.count))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
}
