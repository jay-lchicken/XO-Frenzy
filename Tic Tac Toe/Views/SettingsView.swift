//
//  SettingsView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewViewModel
    @StateObject var gameViewModel: GameViewViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player 1 Icon Selection").font(.headline)) {
                    Picker(selection: $viewModel.xImageName, label: Label("X Icon", systemImage: "xmark.circle")) {
                        ForEach(iconOptions, id: \.self) { icon in
                            Label(icon, systemImage: icon)
                                .tag(icon)
                        }
                    }
                    .pickerStyle(WheelPickerStyle()) // Can change style for variety, e.g., menu, segmented
                }
                
                Section(header: Text("Player 2 Icon Selection").font(.headline)) {
                    Picker(selection: $viewModel.oImageName, label: Label("O Icon", systemImage: "circle")) {
                        ForEach(iconOptions, id: \.self) { icon in
                            Label(icon, systemImage: icon)
                                .tag(icon)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                Section(header: Text("Coin Flip").font(.headline)){
                    Text("Heads (Player 1)/ Tails (Player 2) Starts First")
                    CoinFlip(viewModel: gameViewModel)
                }
                Button{
                    dismiss()
                }label:{
                    ZStack{
                        Capsule()
                            .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1))
                            .frame(width:350, height: 50)
                        Text("Save")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                }
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.red)
        }
    }
    
    private var iconOptions: [String] {
        [
            "xmark", "circle", "square", "scissors", "person.crop.circle.fill.badge.checkmark",
            "person.crop.circle.badge.checkmark", "star", "suit.spade", "suit.club", "star.circle",
            "flashlight.off.fill", "sun.max", "moon.stars.fill", "eye", "hare", "guitars", "tortoise",
            "ant.circle", "cloud.sleet", "location.north.line"
        ]
    }
}
