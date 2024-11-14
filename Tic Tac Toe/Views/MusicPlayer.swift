//
//  MusicPlayer.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//
import SwiftUI
import AVKit

extension Color {
    static func rgb(r: Double, g: Double, b: Double) -> Color {
        return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
    
    static let backgroundColor = Color.rgb(r: 21, g: 22, b: 33)
    static let buttonColor = Color.rgb(r: 15, g: 175, b: 220)
}

struct MusicPlayer1: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var count = 1
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack{
                    Text("MusicPlayer").font(.system(size: 45)).fontWeight(.bold)
                        .foregroundColor(.buttonColor)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        self.audioPlayer.play()
                    }) {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio (contentMode: .fit)
                            .foregroundColor(.buttonColor)
                    }
                    Spacer()
                    Button(action: {
                        self.audioPlayer.pause()
                    }) {
                        Image(systemName: "pause.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio (contentMode: .fit)
                            .foregroundColor(.buttonColor)
                    }
                    Spacer()
                    Button(action: {
                        if self.count < 9 {
                            self.count += 1
                        } else {
                            self.count = 1
                        }
                        let sound = Bundle.main.path(forResource: "song\(self.count)", ofType: "mp3")
                        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                        self.audioPlayer.play()
                    }) {
                        Image(systemName: "forward.end")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .aspectRatio (contentMode: .fit)
                            .foregroundColor(.buttonColor)
                    }
                    Spacer()
                }
            }
        }
        .onAppear() {
            let sound = Bundle.main.path(forResource: "song 1", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.play()

        }
    }
}

                

#Preview {
    ContentView()
}
