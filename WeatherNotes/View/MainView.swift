//
//  MainView.swift
//  WeatherNotes
//
//  Created by Никита on 26.09.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = NoteViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            CustomHeader(viewModel: viewModel)
            
            if viewModel.notesArray.isEmpty {
                ContentUnavailableView(
                    "No notes yet",
                    systemImage: "note.text",
                    description: Text("Tap the + button to create your first note")
                )
                .foregroundStyle(viewModel.blackTheme ? .white : .black)
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    LazyVStack(spacing: 12){
                        ForEach(viewModel.notesArray, id: \.id) { item in
                            VStack{
                                NoteCell(note: item, viewModel: viewModel)
                                    .padding(.top, 14)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear{
            viewModel.notesArray = viewModel.coreDataManager.fetchData()
        }
        .ignoresSafeArea()
        .background(viewModel.blackTheme ? .black.opacity(0.95) : .white)
    }
        
}

#Preview {
    MainView()
}
