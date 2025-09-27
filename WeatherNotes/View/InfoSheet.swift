//
//  InfoSheet.swift
//  WeatherNotes
//
//  Created by Никита on 27.09.2025.
//

import SwiftUI

struct InfoSheet: View {
    
    
    @Binding var isPresented: Bool
    
    @StateObject private var viewModel = NoteViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Weather in \(viewModel.weatherCountry)")
                .foregroundStyle(viewModel.blackTheme ? .white : .black)
                    .font(.title2)
                    .bold()
                
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(viewModel.weatherIcon)@2x.png")) { image in
                    image.resizable()
                         .scaledToFit()
                         .frame(width: 80, height: 80)
                         .shadow(radius: 4)
                } placeholder: {
                    ProgressView()
                }
                
            Text("\(viewModel.weatherDescription.capitalized)\nTemperature: \(viewModel.temperature)")
                    .foregroundStyle(viewModel.blackTheme ? .white : .black)
                    .multilineTextAlignment(.center)
                
                Button("Закрыть") {
                    isPresented = false
                }
                .padding(.top)
            }
            .padding()
            .background(viewModel.blackTheme ? .black.opacity(0.95) : .white)
            .cornerRadius(16)
            .shadow(radius: 8)
            .onAppear{
                Task { await viewModel.weatherInfo() }
            }
    }
}

#Preview {
    InfoSheet(isPresented: .constant(true))
}
