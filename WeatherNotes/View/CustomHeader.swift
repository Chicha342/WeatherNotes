//
//  CustomHeader.swift
//  WeatherNotes
//
//  Created by Никита on 26.09.2025.
//

import SwiftUI

struct CustomHeader: View {
    @ObservedObject var viewModel: NoteViewModel
    @State var isShowSheet: Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .fill(viewModel.blackTheme ? Color.black.opacity(0.7) : Color.black.opacity(0.1))
                    .frame(maxWidth: .infinity, maxHeight: 100)
                
                Text("Weather Notes")
                    .foregroundStyle(viewModel.blackTheme ? .white : .black)
                    .font(.system(size: 21, weight: .semibold, design: .default))
                    .padding(.top, 35)
                
                HStack{
                    Button {
                        print("Theme")
                        withAnimation {
                            viewModel.blackTheme.toggle()
                        }
                        viewModel.defaults.set(viewModel.blackTheme, forKey: "theme")
                    } label: {
                        Image(systemName: "sun.max.fill") //sun.max.fill //moon.fill
                            .resizable()
                            .foregroundStyle(viewModel.blackTheme ? .orange : .blue)
                            .frame(width: 18, height: 18)
                    }
                    
                    Button {
                        print("Delete")
                        withAnimation {
                            viewModel.isDelete.toggle()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .foregroundStyle(viewModel.blackTheme ? .orange : .blue)
                            .frame(width: 18, height: 18)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Plus")
                        isShowSheet = true
                    }, label: {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(viewModel.blackTheme ? .orange : .blue)
                            .frame(width: 18, height: 18)
                    })
                    
                }
                .padding(.horizontal)
                .padding(.top, 35)
            }
        }
        .sheet(isPresented: $isShowSheet) {
            CustomSheet(viewModel: viewModel)
                .ignoresSafeArea()
                .presentationDetents([.fraction(0.2)])
                .presentationDragIndicator(.visible)
        }
        
    }
}

#Preview {
    CustomHeader(viewModel: NoteViewModel())
}
