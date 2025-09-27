//
//  CustomSheet.swift
//  WeatherNotes
//
//  Created by Никита on 26.09.2025.
//

import SwiftUI

struct CustomSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: NoteViewModel
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button("Back") { dismiss() }
                        .foregroundColor(viewModel.blackTheme ? .orange : .blue)

                    Spacer()

                    Button("Save") {
                        if viewModel.text.isEmpty {
                            showAlert = true
                            return
                        }
                        saveNote()
                    }
                    .foregroundColor(viewModel.blackTheme ? .orange : .blue)
                }
                .padding(.horizontal)
                .padding(.top)

                TextField("Enter your note", text: $viewModel.text)
                    .padding()
                    .background(viewModel.blackTheme ? .black.opacity(0.5) : Color.gray.opacity(0.11))
                    .cornerRadius(8)
                    .padding()
            }
            .frame(maxWidth: .infinity)
        }
        .background(viewModel.blackTheme ? .black.opacity(0.95) : .white)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text("Please fill the field"),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    private func saveNote() {
        let currentDate = Date.now.formatted(date: .abbreviated, time: .omitted)
        let currentTime = Date.now.formatted(date: .omitted, time: .shortened)
        
        
        Task{
            do{
                let weather = try await viewModel.networkManager.fetchData()
                let currentWeather = "\(Int(weather.main.temp))°C, \(weather.weather.first?.description ?? "Unknown")"
                
                viewModel.coreDataManager.addItem(id: UUID().uuidString,
                                                  text: viewModel.text,
                                                  date: currentDate,
                                                  time: currentTime,
                                                  weather: currentWeather)
                
                viewModel.notesArray = viewModel.coreDataManager.fetchData()
                viewModel.text = ""
                dismiss()
            }catch{
                print("Error loading weather data: \(error)")
                
                viewModel.coreDataManager.addItem(id: UUID().uuidString,
                                                              text: viewModel.text,
                                                              date: currentDate,
                                                              time: currentTime,
                                                              weather: "no data")
                            
                            viewModel.notesArray = viewModel.coreDataManager.fetchData()
                            viewModel.text = ""
                            dismiss()
            }
        }
        
    }
}

#Preview {
    CustomSheet(viewModel: NoteViewModel())
}
