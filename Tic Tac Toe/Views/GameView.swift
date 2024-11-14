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
                                        if settingsViewModel.AIOPlayer != "off" {
                                            if !viewModel.isPlayerXTurn {
                                                if settingsViewModel.AIOPlayer == "easy"{
                                                    minn = 4
                                                }
                                               
                                                if settingsViewModel.AIOPlayer == "hard"{
                                                    minn = 3
                                                }
                                                print(minn)
                                                if let winningMove = findWinningMove(for: "O", requiredMarks: minn) {
                                                    viewModel.board[winningMove.row][winningMove.col] = "O"
                                                }
                                                else if let blockingMove = findWinningMove(for: "X", requiredMarks: minn) {
                                                    viewModel.board[blockingMove.row][blockingMove.col] = "O"
                                                }
                                                else if viewModel.board[2][2] == "" {
                                                    viewModel.board[2][2] = "O"
                                                }
                                                else {
                                                    var row = Int.random(in: 0..<5)
                                                    var col = Int.random(in: 0..<5)
                                                    while viewModel.board[row][col] != "" {
                                                        row = Int.random(in: 0..<5)
                                                        col = Int.random(in: 0..<5)
                                                    }
                                                    viewModel.board[row][col] = "O"
                                                }
                                                viewModel.checkGameResult()
                                                // Toggle turn
                                                viewModel.isPlayerXTurn.toggle()
                                            }
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
                    }
                }
                .alert(isPresented: $viewModel.showWinningMessage) {
                    Alert(
                        title: Text("Congratulations!"),
                        message: Text(viewModel.gameResult ?? ""),
                        dismissButton: .default(Text("OK"), action: {
                            print("Reset")
                            viewModel.resetGame()
                            viewModel.gameResult = nil
                            
                        })
                    )
                }
                .displayConfetti(isActive: $viewModel.showConfetti)
                .sheet(isPresented: $viewModel.isPresented, onDismiss: {settingsViewModel.save()}) {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures NavigationStack fills screen
    }
    func findWinningMove(for player: String, requiredMarks: Int) -> (row: Int, col: Int)? {
        // Check rows for a potential move
        for row in 0..<5 {
            let emptyCells = viewModel.board[row].enumerated().filter { $0.element == "" }
            let playerCells = viewModel.board[row].filter { $0 == player }
            if emptyCells.count == 5 - requiredMarks && playerCells.count >= requiredMarks {
                return (row, emptyCells[0].offset)
            }
        }
        
        // Check columns for a potential move
        for col in 0..<5 {
            var emptyCell: Int?
            var playerCount = 0
            for row in 0..<5 {
                if viewModel.board[row][col] == player {
                    playerCount += 1
                } else if viewModel.board[row][col] == "" {
                    if emptyCell == nil { emptyCell = row }
                }
            }
            if playerCount >= requiredMarks && (5 - playerCount) <= 5 - requiredMarks {
                if let emptycell = emptyCell{
                    return (emptycell, col)
                }
            }
        }
        
        var emptyCell: Int?
        var playerCount = 0
        for i in 0..<5 {
            if viewModel.board[i][i] == player {
                playerCount += 1
            } else if viewModel.board[i][i] == "" {
                emptyCell = i
            }
        }
        if playerCount >= requiredMarks && (5 - playerCount) <= 5 - requiredMarks {
            if let emptycell = emptyCell{
                return (emptycell, emptycell)
            }
        }
        
        // Check anti-diagonal for a potential move
        emptyCell = nil
        playerCount = 0
        for i in 0..<5 {
            if viewModel.board[i][4 - i] == player {
                playerCount += 1
            } else if viewModel.board[i][4 - i] == "" {
                emptyCell = i
            }
        }
        if playerCount >= requiredMarks && (5 - playerCount) <= 5 - requiredMarks {
            if let emptycell = emptyCell{
                return (emptycell, 4 - emptycell)
            }
        }
        
        // No winning or blocking move found
        return nil
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
                        settingsViewModel.playPop()
                        action()
                    }
                Text("")
            }
        }
           
    }
}


#Preview {
    @StateObject var viewModel = GameViewViewModel()
    GameView(viewModel: viewModel)
}
