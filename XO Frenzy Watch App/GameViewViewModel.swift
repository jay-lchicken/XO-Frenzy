//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//
import SwiftUI
import GameKit
import DataSave
enum PlayerAuthState: String {
    case authenticating = "Logging in to Game Center..."
    case unauthenticated = "Please log in to Game Center"
    case authenticated = ""
    case error = "There was an error with Game Center"
    case restricted = "You are not allowed to play in multiplayer games"
        
}

class GameViewViewModel: ObservableObject {
    func addDelay(seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    @Published var isGameOver = true
    @Published var authenticationState = PlayerAuthState.authenticating
    @Published var musicChoice = "song 3"
    @Published var showWinningMessage = false
    @Published var player1Wins = 0
    @Published var player2Wins = 0
    @Published var draws = 0
    @Published var isPresented = false
    @Published var board: [[String]] = Array(repeating: Array(repeating: "", count: 5), count: 5)
    @Published var isPlayerXTurn: Bool = true
    @Published var gameResult: String? = nil
    @Published var showConfetti = false
    //Game Manager:
    
    init() {
        
        
        }
    
    func checkGameResult() {
        for i in 0..<3 {
            // Check rows for 3 in a row
            if board[i][0] != "" && board[i][0] == board[i][1] && board[i][1] == board[i][2] {
                updateGameResult(for: board[i][0])
                return
            }
            
            // Check columns for 3 in a row
            if board[0][i] != "" && board[0][i] == board[1][i] && board[1][i] == board[2][i] {
                updateGameResult(for: board[0][i])
                return
            }
        }
        
        // Check main diagonal for 3 in a row
        if board[0][0] != "" && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            updateGameResult(for: board[0][0])
            return
        }
        
        // Check anti-diagonal for 3 in a row
        if board[0][2] != "" && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            updateGameResult(for: board[0][2])
            return
        }
        
        // Check for a draw
        if !board.flatMap({ $0 }).contains("") {
            gameResult = "It's a Draw!"
            draws += 1
            showWinningMessage.toggle()
            resetBoard()
            return
        }
    }

    func updateGameResult(for winner: String) {
        if winner == "X" {
            gameResult = "Player X Wins!"
            player1Wins += 1
        } else {
            gameResult = "Player O Wins!"
            player2Wins += 1
        }
        
        resetBoard()
        showConfetti.toggle()
        if showConfetti {
            showWinningMessage = true
            showConfetti = false
        }
    }

    func resetBoard() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        isPlayerXTurn = true
    }
    
    
}
