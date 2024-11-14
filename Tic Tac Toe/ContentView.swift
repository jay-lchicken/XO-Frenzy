//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var startGame: Bool = false
    @StateObject var matchManager = GameViewViewModel()
    var body: some View {
        ZStack{
            if !startGame{
                MenuView(matchManager: matchManager, startGame: $startGame)
                
            }else if startGame{
                GameView(viewModel: matchManager)
            }else{
                MenuView(matchManager: matchManager, startGame: $startGame)
            }
                
        }
        .onAppear{
            matchManager.authenticateUser()
        }
//        VStack {
//            GameView(viewModel: matchManager)
//        }
    }
}

#Preview {
    ContentView()
}
