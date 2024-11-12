//
//  SettingsView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewViewModel
    
    var body: some View {
        Picker("Flavor", selection: $viewModel.xImageName) {
            Image(systemName: "xmark")
                
                .tag("xmark")
            Image(systemName: "circle")
                .tag("circle")
            Image(systemName: "square")
                .tag("square")
            Image(systemName: "scissors")
                .tag("scissors")
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .tag("person.crop.circle.fill.badge.checkmark")
            Image(systemName: "person.crop.circle.badge.checkmark")
                .tag("person.crop.circle.badge.checkmark")
            Image(systemName: "star")
                .tag("star")
            Image(systemName: "suit.spade")
                .tag("suit.spade")
            Image(systemName: "suit.club")
                .tag("suit.club")
            Image(systemName: "star.circle")
                .tag("star.circle")
            Image(systemName: "flashlight.off.fill")
                .tag("flashlight.off.fill")
            Image(systemName: "sun.max")
                .tag("sun.max")
            Image(systemName: "moon.stars.fill")
                .tag("moon.stars.fill")
            Image(systemName: "eye")
                .tag("eye")
            Image(systemName: "hare")
                .tag("hare")
            Image(systemName: "guitars")
                .tag("guitars")
            Image(systemName: "tortoise")
                .tag("tortoise")
            Image(systemName: "ant.circle")
                .tag("ant.circle")
            Image(systemName: "cloud.sleet")
                .tag("cloud.sleet")
            Image(systemName: "person.crop.circle.badge.checkmark")
                .tag("person.crop.circle.badge.checkmark")
            Image(systemName: "location.north.line")
                .tag("location.north.line")
        }
        Picker("Flavor", selection: $viewModel.oImageName) {
            Image(systemName: "xmark")
                .tag("xmark")
            Image(systemName: "circle")
                .tag("circle")
            Image(systemName: "square")
                .tag("square")
            Image(systemName: "scissors")
                .tag("scissors")
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .tag("person.crop.circle.fill.badge.checkmark")
            Image(systemName: "person.crop.circle.badge.checkmark")
                .tag("person.crop.circle.badge.checkmark")
            Image(systemName: "star")
                .tag("star")
            Image(systemName: "suit.spade")
                .tag("suit.spade")
            Image(systemName: "suit.club")
                .tag("suit.club")
            Image(systemName: "star.circle")
                .tag("star.circle")
            Image(systemName: "flashlight.off.fill")
                .tag("flashlight.off.fill")
            Image(systemName: "sun.max")
                .tag("sun.max")
            Image(systemName: "moon.stars.fill")
                .tag("moon.stars.fill")
            Image(systemName: "eye")
                .tag("eye")
            Image(systemName: "hare")
                .tag("hare")
            Image(systemName: "guitars")
                .tag("guitars")
            Image(systemName: "tortoise")
                .tag("tortoise")
            Image(systemName: "ant.circle")
                .tag("ant.circle")
            Image(systemName: "cloud.sleet")
                .tag("cloud.sleet")
            Image(systemName: "person.crop.circle.badge.checkmark")
                .tag("person.crop.circle.badge.checkmark")
            Image(systemName: "location.north.line")
                .tag("location.north.line")
        }
        .tint(Color.red)
    }
        
}


