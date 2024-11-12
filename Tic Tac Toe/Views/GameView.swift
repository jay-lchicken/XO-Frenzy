//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import SwiftUI

struct GameView: View {
    @State var viewModel = GameViewViewModel()
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Tic-Tac-Toe")
                .font(.largeTitle)
                .padding()
            
            if gameResult == nil {
                Text(viewModel.isPlayerXTurn ? "Player X's Turn" : "Player O's Turn")
                    .font(.headline)
            } else {
                Text(gameResult ?? "")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { col in
                        CellView(mark: $board[row][col]) {
                            
                            if board[row][col] == "" && gameResult == nil {
                                board[row][col] = isPlayerXTurn ? "X" : "O"
                                isPlayerXTurn.toggle()
                                checkGameResult()
                            }
                        }
                    }
                }
            }
            
            // Reset Button
            Button(action: resetGame) {
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
