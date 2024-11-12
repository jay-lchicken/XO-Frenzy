//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//
import SwiftUI

class GameViewViewModel: ObservableObject {
    @Published var player1Wins = 0
    @Published var player2Wins = 0
    @Published var draws = 0
    @Published var isPresented = false
    @Published var board: [[String]] = Array(repeating: Array(repeating: "", count: 5), count: 5)
    @Published var isPlayerXTurn: Bool = true
    @Published var gameResult: String? = nil
    @Published var showConfetti = false
    init(){
        self.isPresented = true
    }
    func checkGameResult() {
        for i in 0..<5 {
            // Check rows
            if board[i][0] != "" && board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][2] == board[i][3] && board[i][3] == board[i][4] {
                if board[i][0] == "X" {
                    gameResult = "Player 1 Wins!"
                    player1Wins+=1
                    board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
                    isPlayerXTurn = true
                    gameResult = nil
                    
                } else {
                    gameResult = "Player 2 Wins!"
                    player2Wins+=1
                    board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
                    isPlayerXTurn = true
                    gameResult = nil
                    
                }
                showConfetti.toggle()
                return
            }
            
            // Check columns
            if board[0][i] != "" && board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[2][i] == board[3][i] && board[3][i] == board[4][i] {
                if board[0][i] == "X" {
                    gameResult = "Player 1 Wins!"
                    player1Wins+=1
                    board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
                    isPlayerXTurn = true
                    gameResult = nil
                } else {
                    gameResult = "Player 2 Wins!"
                    player2Wins+=1
                    board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
                    isPlayerXTurn = true
                    gameResult = nil
                }
                showConfetti.toggle()

                return
            }
        }
        
        // Check main diagonal
        if board[0][0] != "" && board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[2][2] == board[3][3] && board[3][3] == board[4][4] {
            if board[0][0] == "X" {
                gameResult = "Player 1 Wins!"
                player1Wins+=1
                board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
                isPlayerXTurn = true
                gameResult = nil
            } else {
                gameResult = "Player 2 Wins!"
                player2Wins+=1
                board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
                isPlayerXTurn = true
                gameResult = nil
            }
            showConfetti.toggle()

            return
        }
        
        // Check anti-diagonal
        if board[0][4] != "" && board[0][4] == board[1][3] && board[1][3] == board[2][2] && board[2][2] == board[3][1] && board[3][1] == board[4][0] {
            if board[0][4] == "X" {
                gameResult = "Player 1 Wins!"
                player1Wins+=1
                board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
                isPlayerXTurn = true
                gameResult = nil
            } else {
                gameResult = "Player 2 Wins!"
                player2Wins+=1
                board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
                isPlayerXTurn = true
                gameResult = nil
            }
            showConfetti.toggle()

            return
        }
        
        // Check for a draw
        if !board.flatMap({ $0 }).contains("") {
            gameResult = "It's a Draw!"
            draws+=1
            board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
            isPlayerXTurn = true
            gameResult = nil
        }
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: "", count: 5), count: 5) // Updated to 5x5
        isPlayerXTurn = true
        gameResult = nil
    }
}
