//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//
import SwiftUI

class GameViewViewModel: ObservableObject {
    @Published var isPresented = false
    @Published var board: [[String]] = Array(repeating: Array(repeating: "", count: 5), count: 5)
    @Published var isPlayerXTurn: Bool = true
    @Published var gameResult: String? = nil
    init(){
        self.isPresented = true
    }
    func checkGameResult() {
        for i in 0..<5 {
            // Check rows
            if board[i][0] != "" && board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][2] == board[i][3] && board[i][3] == board[i][4] {
                gameResult = "\(board[i][0]) Wins!"
                return
            }
            
            // Check columns
            if board[0][i] != "" && board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[2][i] == board[3][i] && board[3][i] == board[4][i] {
                gameResult = "\(board[0][i]) Wins!"
                return
            }
        }
        
        // Check main diagonal
        if board[0][0] != "" && board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[2][2] == board[3][3] && board[3][3] == board[4][4] {
            gameResult = "\(board[0][0]) Wins!"
            return
        }
        
        // Check anti-diagonal
        if board[0][4] != "" && board[0][4] == board[1][3] && board[1][3] == board[2][2] && board[2][2] == board[3][1] && board[3][1] == board[4][0] {
            gameResult = "\(board[0][4]) Wins!"
            return
        }
        
        // Check for a draw
        if !board.flatMap({ $0 }).contains("") {
            gameResult = "It's a Draw!"
        }
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
        isPlayerXTurn = true
        gameResult = nil
    }
}
