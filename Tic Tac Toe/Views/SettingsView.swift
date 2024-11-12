//
//  SettingsView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel = SettingsViewViewModel()
    
    var body: some View {
        Picker("Flavor", selection: $viewModel.xImageName) {
            Image(systemName: "xmark")
                .tag("xmark")
            Image(systemName: "circle")
                .tag("circle")
            
        }

    }
}

#Preview {
    SettingsView()
}
