//
//  CoinFlip.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//
import SwiftUI
import AudioToolbox
struct CoinFlip: View {
    @StateObject var viewModel: GameViewViewModel
    @State var flipping = false
    @State var heads = true
    @State var tailsCount: Int = 0
    @State var headsCount: Int = 0
    @State var degreesToFlip: Int = 0
    
    var body: some View {
        HStack{
            Spacer()
            Coin(flipping: $flipping, heads: $heads)
                .rotation3DEffect (Angle(degrees: Double(degreesToFlip)), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
            Spacer()
        }
            Button {
                flipCoin()
                viewModel.actionButtonThree(SystemSoundID(kSystemSoundID_Vibrate))
            }label: {
                ZStack{
                    Capsule()
                        .fill(Color(red: 27/255.0, green: 20/255.0, blue: 100/255.0).opacity(1))
                        .frame(width:350, height: 50)
                    Text("Flip the Coin")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
            }
    }
    
    func flipCoin() {
        withAnimation {
            let randomNumber = Int.random(in: 5...100)
            if degreesToFlip > 18000000 {
                reset()
            }
            degreesToFlip = degreesToFlip + (randomNumber * 180)
            HeadsOrTails()
            flipping.toggle()
        }
        
    }
    
    func HeadsOrTails() {
        let divisible = degreesToFlip / 180
        (divisible % 2) == 0 ? (heads = false) : (heads = true)
        if heads{
            viewModel.isPlayerXTurn = true
        }else{
            viewModel.isPlayerXTurn = false
        }
    }
    
    func reset() {
        degreesToFlip = 0
    }
}

struct Coin: View {
    @Binding var flipping: Bool
    @Binding var heads : Bool
    var body: some View {
        ZStack {
            if heads {
                Image("heads")
                    .resizable()
                    .frame(width: 100, height: 100)
            } else {
                Image("tails")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
    }
}

