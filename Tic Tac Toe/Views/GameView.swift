//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewViewModel()
    @StateObject var settingsViewModel = SettingsViewViewModel() // Fixed spelling

    var body: some View {
        VStack(spacing: 20) {
            Text("Tic-Tac-Toe")
                .font(.largeTitle)
                .padding()
            
            if viewModel.gameResult == nil {
                if viewModel.isPlayerXTurn {
                    HStack{
                        Image(systemName: settingsViewModel.xImageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("'s Turn")
                    }
                    
                } else {
                    Image(systemName: settingsViewModel.oImageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("'s Turn")
                }
                
            } else {
                Text(viewModel.gameResult ?? "")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            
            ForEach(0..<5) { row in
                HStack {
                    ForEach(0..<5) { col in
                        CellView(settingsViewModel: settingsViewModel, mark: $viewModel.board[row][col]) {
                            if viewModel.board[row][col] == "" && viewModel.gameResult == nil {
                                viewModel.board[row][col] = viewModel.isPlayerXTurn ? "X" : "O"
                                viewModel.isPlayerXTurn.toggle()
                                viewModel.checkGameResult()
                            }
                        }
                    }
                }
            }
            
            Button(action: viewModel.resetGame) {
                Text("Reset Game")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: { viewModel.isPresented.toggle() }) {
                Text("Settings")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.isPresented) {
            SettingsView(viewModel: settingsViewModel)
        }
    }
}

struct CellView: View {
    @StateObject var settingsViewModel : SettingsViewViewModel
    @Binding var mark: String
    var action: () -> Void
    
    var body: some View {
        if mark == "X"{
            Image(systemName: settingsViewModel.xImageName)
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.1))
                .border(Color.black, width: 2)
                .onTapGesture {
                    action()
                }
        }
        if mark == "O"{
            Image(systemName: settingsViewModel.oImageName)
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.1))
                .border(Color.black, width: 2)
                .onTapGesture {
                    action()
                }
        }
        
        if mark.isEmpty{
            Text("")
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.1))
                .border(Color.black, width: 2)
                .onTapGesture {
                    action()
                }
            
        }
           
    }
}


#Preview {
    GameView()
}
