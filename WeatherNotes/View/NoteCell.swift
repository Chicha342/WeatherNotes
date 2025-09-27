//
//  NoteCell.swift
//  WeatherNotes
//
//  Created by Никита on 26.09.2025.
//

import SwiftUI

struct NoteCell: View {
    var note: NoteModel
    @ObservedObject var viewModel: NoteViewModel
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack{
                    Text(note.text ?? "no data")
                        .foregroundStyle(viewModel.blackTheme ? .white : .black)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                    
                    Spacer()
                    
                    Text(note.time ?? "no data")
                        .foregroundStyle(.gray)
                        .font(.system(size: 14, weight: .regular, design: .default))
                    
                    Text(note.date ?? "no data")
                        .foregroundStyle(.gray)
                        .font(.system(size: 14, weight: .regular, design: .default))
                }
                
                Text("\(note.weather ?? "no data")")
                    .foregroundStyle(viewModel.blackTheme ? .white : .black)
                
                
            }
            .padding(.horizontal)
            .padding()
            .background(viewModel.blackTheme ? .black : .white)
            .cornerRadius(12)
            .shadow(radius: 8)
            
            if viewModel.isDelete {
                Button(action: {
                    withAnimation {
                        viewModel.deleteNote(note)
                    }
                }, label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.red.opacity(0.7))
                        .clipShape(Circle())
                })
            }
        }
        
    }
}

#Preview {
    NoteCell(note: NoteModel(context: CoreDataManager.shared.context), viewModel: NoteViewModel())
}
