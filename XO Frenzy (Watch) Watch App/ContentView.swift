//
//  ContentView.swift
//  XOFrenzy (Watch) Watch App
//
//  Created by Lai Hong Yu on 11/14/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: GameViewViewModel
    @StateObject var settingsViewModel = SettingsViewViewModel()
    
    var body: some View {
        ScrollView{
            VStack {
                ForEach(0..<3) { row in
                    HStack {
                        ForEach(0..<3) { col in
                            CellView(settingsViewModel: settingsViewModel, mark: $viewModel.board[row][col]) {
                                if viewModel.board[row][col] == "" && viewModel.gameResult == nil {
                                    viewModel.board[row][col] = viewModel.isPlayerXTurn ? "X" : "O"
                                    viewModel.isPlayerXTurn.toggle()
                                    viewModel.checkGameResult()
                                                                    
                                    if settingsViewModel.AIOPlayer != "off" && !viewModel.isPlayerXTurn {
                                        viewModel.checkGameResult()
                                        viewModel.isPlayerXTurn.toggle()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Button{
                viewModel.resetBoard()
            }label:{
                Text("Reset Game")
            }
            .handGestureShortcut(.primaryAction)
        }
        .alert(isPresented: $viewModel.showWinningMessage) {
            Alert(
                title: Text("Congratulations!"),
                message: Text(viewModel.gameResult ?? ""),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.resetBoard()
                    viewModel.gameResult = nil
                })
            )
        }

    }
}
struct CellView: View {
    @StateObject var settingsViewModel : SettingsViewViewModel
    @Binding var mark: String
    var action: () -> Void
    
    var body: some View {
        if mark == "X"{
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(settingsViewModel.colour) // Fill with color to have rounded background
                    .frame(width: 50, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .onTapGesture {
                        action()
                    }
                Image(systemName: settingsViewModel.xImageName)
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
            }
        }
        if mark == "O"{
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(settingsViewModel.colour) // Fill with color to have rounded background
                    .frame(width: 50, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .onTapGesture {
                        action()
                    }
                Image(systemName: settingsViewModel.oImageName)
                    .foregroundStyle(.white)

                    .frame(width: 50, height: 50)
            }
        }
        
        if mark.isEmpty{
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(settingsViewModel.colour) // Fill with color to have rounded background
                    .frame(width: 50, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .onTapGesture {
                        action()
                    }
            }
        }
           
    }
}
#Preview {
    ContentView(viewModel: GameViewViewModel())
}
