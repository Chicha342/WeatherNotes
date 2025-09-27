//
//  CoreDataService.swift
//  WeatherNotes
//
//  Created by Никита on 26.09.2025.
//

import Foundation
import CoreData

class CoreDataManager {
    public static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    var context: NSManagedObjectContext { container.viewContext }
    
    private init() {
        container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores{ _ , error in
            if let error = error {
                print("Error loading CoreData: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print("CoreData save error: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: CRUD
    
    //create
    func addItem(id: String, text: String, date: String, time: String, weather: String) {
        let item = NoteModel(context: CoreDataManager.shared.context)
        item.id = id
        item.text = text
        item.date = date
        item.time = time
        item.weather = weather
        CoreDataManager.shared.save()
    }
    
    //read
    func fetchData() -> [NoteModel] {
        let request: NSFetchRequest<NoteModel> = NoteModel.fetchRequest()
        return (try? CoreDataManager.shared.context.fetch(request)) ?? []
    }
    
    //update
    func updateItem(_ item: NoteModel, newText: String) {
        item.text = newText
        CoreDataManager.shared.save()
    }
    
    //delete
    func deleteItem(_ item: NoteModel) {
        CoreDataManager.shared.context.delete(item)
        CoreDataManager.shared.save()
    }
}
