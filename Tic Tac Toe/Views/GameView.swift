//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewViewModel()
    @StateObject var settingsViewModel = SettingsViewViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Tic-Tac-Toe")
                .font(.custom("Times New Roman", size: 50))
                .bold()
                .padding()

            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0))
                        .opacity(1) // Ensures full opacity

                    HStack(spacing: 30) {
                        VStack {
                            Text("Player 1")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                            Text("\(viewModel.player1Wins)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.green)
                        }
                        
                        VStack {
                            Text("Draws")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)

                            Text("\(viewModel.draws)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            Text("Player 2")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)

                            Text("\(viewModel.player2Wins)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                }
                .padding()
            }
            
            // Game status and board
            if viewModel.gameResult == nil {
                if viewModel.isPlayerXTurn {
                    HStack {
                        Image(systemName: settingsViewModel.xImageName)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("'s Turn (Player 1)")
                    }
                } else {
                    HStack {
                        Image(systemName: settingsViewModel.oImageName)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("'s Turn (Player 2)")
                    }
                }
            } else {
                Text(viewModel.gameResult ?? "")
                    .font(.headline)
                    .font(.system(size: 30))
                    .foregroundColor(.red)
            }

            // Game board
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
            Button{
                viewModel.resetGame()
            }label:{
                ZStack{
                    Capsule()
                        .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1))
                        .frame(width:350, height: 50)
                    Text("Save")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
                
            }
            Button{
                viewModel.isPresented.toggle()
            }label:{
                ZStack{
                    Capsule()
                        .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1))
                        .frame(width:350, height: 50)
                    Text("Open Settings")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
                
            }
                    }
        .alert(isPresented: $viewModel.showConfetti) {
            Alert(title: Text("Congratulations!"), message: Text(viewModel.gameResult ?? ""), dismissButton: .default(Text("OK")))
        }
        .displayConfetti(isActive: $viewModel.showConfetti)
        .sheet(isPresented: $viewModel.isPresented) {
            SettingsView(viewModel: settingsViewModel, gameViewModel: viewModel)
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
                    .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1)) // Fill with color to have rounded background
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
                    .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1)) // Fill with color to have rounded background
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
                    .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1)) // Fill with color to have rounded background
                    .frame(width: 50, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .onTapGesture {
                        action()
                    }
                Text("")
            }
        }
           
    }
}


#Preview {
    GameView()
}
