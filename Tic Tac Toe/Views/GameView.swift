//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//


import SwiftUI
import AudioToolbox

struct GameView: View {
    @StateObject var viewModel: GameViewViewModel
    @StateObject var settingsViewModel = SettingsViewViewModel()
    @State var minn = 0
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("XO Frenzy")
                                           .font(.custom("Lemon Round", size: 50))
                                           .bold()
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0))
                                .opacity(1) // Ensures full opacity
                                .frame(width: 350, height: 100)
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
                        }
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
                                        viewModel.actionButtonTwo(SystemSoundID(kSystemSoundID_Vibrate))
                                        
                                        if settingsViewModel.AIOPlayer != "off" && !viewModel.isPlayerXTurn {
                                            aiMakeMove()
                                            viewModel.checkGameResult()
                                            viewModel.isPlayerXTurn.toggle()
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Button {
                        viewModel.resetGame()
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1))
                                .frame(width: 350, height: 50)
                            Text("Reset")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }

                    Button {
                        viewModel.isPresented.toggle()
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1))
                                .frame(width: 350, height: 50)
                            Text("Open Settings")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }                }
                .alert(isPresented: $viewModel.showWinningMessage) {
                    Alert(
                        title: Text("Congratulations!"),
                        message: Text(viewModel.gameResult ?? ""),
                        dismissButton: .default(Text("OK"), action: {
                            viewModel.resetGame()
                            viewModel.showConfetti.toggle()
                            viewModel.gameResult = nil
                        })
                    )
                }
                .displayConfetti(isActive: $viewModel.showConfetti)
                .sheet(isPresented: $viewModel.isPresented, onDismiss: { settingsViewModel.save() }) {
                    SettingsView(viewModel: settingsViewModel, gameViewModel: viewModel)
                }
                .toolbar {
                    Button {
                        if viewModel.audioPlayer.isPlaying {
                            viewModel.audioPlayer.pause()
                        } else {
                            viewModel.audioPlayer.play()
                        }
                    } label: {
                        Image(systemName: "playpause")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // AI move logic
    private func aiMakeMove() {
        let isHardMode = settingsViewModel.AIOPlayer == "hard"
        let requiredMarks = isHardMode ? 2 : 3

        // First, check for a winning move or a blocking move
        if let move = findWinningMove(for: "O", requiredMarks: requiredMarks) {
            viewModel.board[move.row][move.col] = "O"
        }else if let move = findWinningMove(for: "X", requiredMarks: requiredMarks) {
            viewModel.board[move.row][move.col] = "O"
        }
        // Center move preference
        else if viewModel.board[2][2] == "" {
            viewModel.board[2][2] = "O"
        }
        // Random move if no better options
        else {
            placeRandomMove()
        }
    }

    // Find winning or blocking move
    private func findWinningMove(for player: String, requiredMarks: Int) -> (row: Int, col: Int)? {
        let opponent = (player == "X") ? "O" : "X"

        // Check rows, columns, and diagonals
        for index in 0..<5 {
            if let rowMove = checkLine(for: player, in: viewModel.board[index], requiredMarks: requiredMarks, lineType: .row, index: index) {
                return rowMove
            }
            let column = (0..<5).map { viewModel.board[$0][index] }
            if let colMove = checkLine(for: player, in: column, requiredMarks: requiredMarks, lineType: .col, index: index) {
                return colMove
            }
        }
        return checkDiagonals(for: player, requiredMarks: requiredMarks)
    }

    // Check row/column logic
    private func checkLine(for player: String, in line: [String], requiredMarks: Int, lineType: LineType, index: Int) -> (row: Int, col: Int)? {
        let emptyCells = line.enumerated().filter { $0.element == "" }
        let playerCells = line.filter { $0 == player }

        if emptyCells.count == 5 - requiredMarks && playerCells.count >= requiredMarks {
            if lineType == .row {
                return (index, emptyCells[0].offset)
            } else if lineType == .col {
                return (emptyCells[0].offset, index)
            }
        }
        return nil
    }

    // Check diagonals for winning/blocking moves
    private func checkDiagonals(for player: String, requiredMarks: Int) -> (row: Int, col: Int)? {
        var emptyCells = [(Int, Int)]()
        var playerCount = 0
        
        // Main diagonal
        for i in 0..<5 {
            if viewModel.board[i][i] == player {
                playerCount += 1
            } else if viewModel.board[i][i] == "" {
                emptyCells.append((i, i))
            }
        }
        if emptyCells.count == 5 - requiredMarks && playerCount >= requiredMarks {
            return emptyCells[0]
        }

        // Anti-diagonal
        emptyCells = []
        playerCount = 0
        for i in 0..<5 {
            if viewModel.board[i][4 - i] == player {
                playerCount += 1
            } else if viewModel.board[i][4 - i] == "" {
                emptyCells.append((i, 4 - i))
            }
        }
        if emptyCells.count == 5 - requiredMarks && playerCount >= requiredMarks {
            return emptyCells[0]
        }

        return nil
    }

    // AI random move
    private func placeRandomMove() {
        var row = Int.random(in: 0..<5)
        var col = Int.random(in: 0..<5)
        while viewModel.board[row][col] != "" {
            row = Int.random(in: 0..<5)
            col = Int.random(in: 0..<5)
        }
        viewModel.board[row][col] = "O"
    }
}

// Enum to clarify line type in AI logic
enum LineType {
    case row, col
}

#Preview {
    @StateObject var viewModel = GameViewViewModel()
    GameView(viewModel: viewModel)
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
                        settingsViewModel.playPop()
                        action()
                    }
                Text("")
            }
        }
           
    }
}
