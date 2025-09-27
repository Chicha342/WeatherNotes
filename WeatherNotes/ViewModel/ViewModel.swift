//
//  ViewModel.swift
//  WeatherNotes
//
//  Created by Никита on 26.09.2025.
//

import Foundation

class NoteViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isDelete: Bool = false
    
    @Published var blackTheme: Bool {
        didSet{
            defaults.set(blackTheme, forKey: "theme")
        }
    }
    
    @Published var networkManager = NetworkService()
    @Published var coreDataManager = CoreDataManager.shared
    
    let defaults = UserDefaults.standard
    
    @Published var notesArray : [NoteModel] = []
    
    init() {
        self.blackTheme = defaults.bool(forKey: "theme")
    }
    
    func deleteNote(_ note: NoteModel) {
        coreDataManager.deleteItem(note)
        notesArray = coreDataManager.fetchData()
    }
}
