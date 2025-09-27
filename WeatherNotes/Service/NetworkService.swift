//
//  NetworkService.swift
//  WeatherNotes
//
//  Created by Никита on 26.09.2025.
//

import Foundation
class NetworkService: ObservableObject {
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Kyiv&appid=dcbd7145cc36294ccc05322b508ed637&units=metric&lang=ru"
    
    //dcbd7145cc36294ccc05322b508ed637
    //https://api.openweathermap.org/data/2.5/weather?q=Kyiv&appid=dcbd7145cc36294ccc05322b508ed637&units=metric&lang=ru
    
    func fetchData() async throws -> WeatherModel {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(WeatherModel.self, from: data)
        return decoded
    }
}
