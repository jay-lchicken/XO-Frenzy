//
//  MenuView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/14/24.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var matchManager: GameViewViewModel
    @Binding var startGame: Bool

    var body: some View {
        VStack {
            Spacer()
            
            Text("XO Frenzy")
                .font(.custom("Lemon Round", size:  75))
                .fontWeight(.bold)
                .foregroundColor(.yellow)
            
            Image("icon")
                .resizable()
                .cornerRadius(10)
                .frame(width: 300, height: 300)
            Spacer()
            Button {
                startGame = true
            } label: {
                Text("PLAY")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .bold()
            }
            .disabled(matchManager.authenticationState != .authenticated || !matchManager.isGameOver)
            .padding(.vertical, 20)
            .padding(.horizontal, 100)
            .background {
                Capsule(style: .circular)
                    .fill(matchManager.authenticationState == .authenticated ? Color.green : Color.gray)
            }
            Text(matchManager.authenticationState.rawValue)
                .font(.custom("Lemon Round", size:  30))
                .foregroundColor(.yellow)

            Spacer()
        }
        .background{
            Rectangle()
                .foregroundStyle(.blue)
                .frame(width: 1000, height: 1000)
        }
        
    }
   
}
