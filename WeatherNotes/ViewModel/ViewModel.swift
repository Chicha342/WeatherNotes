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
    
    @Published var isShowAletrInfo: Bool = false
    
    @Published var temperature = ""
    @Published var weatherCountry = ""
    @Published var weatherDescription = ""
    @Published var weatherIcon = ""
    
    let defaults = UserDefaults.standard
    
    @Published var notesArray : [NoteModel] = []
    
    init() {
        self.blackTheme = defaults.bool(forKey: "theme")
    }
    
    func deleteNote(_ note: NoteModel) {
        coreDataManager.deleteItem(note)
        notesArray = coreDataManager.fetchData()
    }
    
    func weatherInfo() async {
        Task{
            let weather = try await self.networkManager.fetchData()
            self.temperature = "\(Int(weather.main.temp))°C"
            self.weatherCountry = "\(weather.name)"
            self.weatherDescription = "\(weather.weather.first?.description.capitalized ?? "No data")"
            self.weatherIcon = "\(weather.weather.first?.icon ?? "01d")"
        }
    }
}
