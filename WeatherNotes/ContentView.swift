//
//  ContentView.swift
//  WeatherNotes
//
//  Created by Никита on 26.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NoteViewModel()
    
    var body: some View {
        VStack {
            MainView()
        }
    }
}

#Preview {
    ContentView()
}
