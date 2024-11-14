//
//  XO_Frenzy__Watch_App.swift
//  XO Frenzy (Watch) Watch App
//
//  Created by Lai Hong Yu on 11/14/24.
//

import SwiftUI

@main
struct XO_Frenzy__Watch__Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: GameViewViewModel())
        }
    }
}
