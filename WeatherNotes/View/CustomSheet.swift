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
                        viewModel.saveNote {
                            dismiss()
                        }
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
    
}

#Preview {
    CustomSheet(viewModel: NoteViewModel())
}
