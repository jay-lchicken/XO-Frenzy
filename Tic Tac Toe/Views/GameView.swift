//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewViewModel()
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Tic-Tac-Toe")
                .font(.largeTitle)
                .padding()
            
            if viewModel.gameResult == nil {
                Text(viewModel.isPlayerXTurn ? "Player X's Turn" : "Player O's Turn")
                    .font(.headline)
            } else {
                Text(viewModel.gameResult ?? "")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { col in
                        CellView(mark: $viewModel.board[row][col]) {
                            
                            
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
            .padding()
            
        }
    }
    
    
}

struct CellView: View {
    @Binding var mark: String
    var action: () -> Void
    
    var body: some View {
        Text(mark)
            .font(.largeTitle)
            .frame(width: 80, height: 80)
            .background(Color.gray.opacity(0.1))
            .border(Color.black, width: 2)
            .onTapGesture {
                action()
            }
    }
}


#Preview {
    GameView()
}
