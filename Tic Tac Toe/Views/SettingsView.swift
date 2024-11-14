//
//  SettingsView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import SwiftUI
import DataSave
extension Color {
    func toRGBA() -> [String: CGFloat] {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return ["red": red, "green": green, "blue": blue, "alpha": alpha]
    }

    init?(rgba: [String: CGFloat]) {
        guard
            let red = rgba["red"],
            let green = rgba["green"],
            let blue = rgba["blue"],
            let alpha = rgba["alpha"]
        else {
            return nil
        }
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
struct SettingsView: View {
    @StateObject var viewModel: SettingsViewViewModel
    @StateObject var gameViewModel: GameViewViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            Form {
                Section(header:Text("AI Player For 2nd Player").font(.headline)) {
                    Picker(selection: $viewModel.AIOPlayer, label: Label("AI Player", systemImage: "brain.head.profile")) {
                        Text("Off")
                            .tag("off")
                        Text("Easy")
                            .tag("easy")

                        Text("Hard")
                            .tag("hard")

                    }
                    
                }
                Section(header: Text("Player 1 Icon Selection").font(.headline)) {
                    Picker(selection: $viewModel.xImageName, label: Label("X Icon", systemImage: "xmark.circle")) {
                        ForEach(iconOptions.indices, id: \.self) { index in
                            Label(iconOptionsName[index], systemImage: iconOptions[index])
                                .tag(iconOptions[index])
                        }
                    }
                    .pickerStyle(WheelPickerStyle()) // Can change style for variety, e.g., menu, segmented
                }
                
                Section(header: Text("Player 2 Icon Selection").font(.headline)) {
                    Picker(selection: $viewModel.oImageName, label: Label("O Icon", systemImage: "circle")) {
                        ForEach(iconOptions.indices, id: \.self) { index in
                            Label(iconOptionsName[index], systemImage: iconOptions[index])
                                .tag(iconOptions[index])
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Section(header: Text("Theme (Marks are white)").font(.headline)) {
                    Picker(selection: $viewModel.colour, label: Label("Colours", systemImage: "paintpalette")) {
                        ForEach(colorValues.indices, id: \.self) { index in
                            Text("\(colorOptionsName[index])")
                                .tag(colorValues[index])
                        }
                        
                    }
                }
                Section(header: Text("Music").font(.headline)) {
                    Picker(selection: $viewModel.musicChoice, label: Label("Music Choice", systemImage: "music.note")) {
                        Text("Default")
                            .tag("song 3")
                        Text("Song 1")
                            .tag("song 2")
                        Text("Song 2")
                            .tag("Song 1")
                        
                    }
                    Text("These copyright free music is claimed from Pixabay 2024")
                    Text("For the song to be played, please restart the app")
                }
                Section(header: Text("Coin Flip").font(.headline)){
                    Text("Heads (Player 1)/ Tails (Player 2) Starts First")
                    CoinFlip(viewModel: gameViewModel)
                }
                
                Section(header: Text("Reset").font(.headline)){
                    Button{
                        gameViewModel.resetGame()
                        gameViewModel.player1Wins = 0
                        gameViewModel.player2Wins = 0
                        gameViewModel.draws = 0
                    }label:{
                        ZStack{
                            Capsule()
                                .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1))
                                .frame(width:350, height: 50)
                            Text("Reset all scores")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                        
                    }
                }
                Button{
                    viewModel.generator.notificationOccurred(.success)
                    let firstIcon = viewModel.xImageName
                    let secondIcon = viewModel.oImageName
                    let colours = viewModel.colour
                    let musicChoiceSaved = DataSave.saveToUserDefaults(viewModel.musicChoice, forKey: "musicChoice")
                    let firstIconSaved = DataSave.saveToUserDefaults(firstIcon, forKey: "firstIcon")
                    let secondIconSaved = DataSave.saveToUserDefaults(secondIcon, forKey: "secondIcon")
                    let colourRGBA = viewModel.colour.toRGBA()
                    let coloursSaved = DataSave.saveToUserDefaults(colourRGBA, forKey: "colour")

                    

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
    private var iconOptionsName: [String] {
        [
            "X", "O", "Square", "Scissors", "Person with Checkmark",
            "Person with checkmark 2", "Star", "Suit Spade", "Suit Club", "Star Circle",
            "Flashlight (Off)", "Sun", "Moon", "Eye", "Hare", "Guitars", "Tortoise",
            "Ant", "Cloud", "Location North", "Heart", "Leaf", "Bolt", "Shield", "Bell",
            "Paperclip", "House", "Briefcase", "Book", "Map", "Globe", "Wrench", "Cart",
            "Keyboard", "Puzzle", "Lock", "Paint Palette", "Bicycle", "Car", "Train", "Airplane"
        ]
    }
    private var iconOptions: [String] {
        [
            "xmark", "circle", "square", "scissors", "person.crop.circle.fill.badge.checkmark",
            "person.crop.circle.badge.checkmark", "star", "suit.spade", "suit.club", "star.circle",
            "flashlight.off.fill", "sun.max", "moon.stars.fill", "eye", "hare", "guitars", "tortoise",
            "ant.circle", "cloud.sleet", "location.north.line", "heart.fill", "leaf.fill", "bolt.fill",
            "shield.fill", "bell.fill", "paperclip", "house.fill", "briefcase.fill", "book.fill",
            "map.fill", "globe", "wrench.fill", "cart.fill", "keyboard", "puzzlepiece.fill",
            "lock.fill", "paintpalette.fill", "bicycle", "car.fill", "train.side.front.car",
            "airplane"
        ]
    }
    private var colorOptionsName: [String] {
        [
            "Default","Red", "Orange", "Yellow", "Green", "Mint", "Teal", "Cyan", "Blue",
            "Indigo", "Purple", "Pink", "Brown", "Gray", "Black", "White"
        ]
    }

    private var colorValues: [Color] {
        [
            Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1),.red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue,
            .indigo, .purple, .pink, .brown, .gray, .black, .white
        ]
    }
}


