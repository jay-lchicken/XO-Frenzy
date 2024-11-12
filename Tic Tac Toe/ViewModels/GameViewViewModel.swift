//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import SwiftUI

class GameViewViewModel: ObservableObject{
    @Published var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @Published var isPlayerXTurn: Bool = true
    @Published var gameResult: String? = nil
    init(){}
    func checkGameResult() {
        for i in 0..<3 {
            if board[i][0] != "" && board[i][0] == board[i][1] && board[i][1] == board[i][2] {
                gameResult = "\(board[i][0]) Wins!"
                return
            }
            if board[0][i] != "" && board[0][i] == board[1][i] && board[1][i] == board[2][i] {
                gameResult = "\(board[0][i]) Wins!"
                return
            }
        }
        if board[0][0] != "" && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            gameResult = "\(board[0][0]) Wins!"
            return
        }
        if board[0][2] != "" && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            gameResult = "\(board[0][2]) Wins!"
            return
        }
    
        if !board.flatMap({ $0 }).contains("") {
            gameResult = "It's a Draw!"
        }
    }
    
     func resetGame() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        isPlayerXTurn = true
        gameResult = nil
    }
}
