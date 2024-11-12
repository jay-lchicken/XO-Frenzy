//
//  SettingsView.swift
//  Tic Tac Toe
//
//  Created by Lai Hong Yu on 11/12/24.
//

import Foundation
class SettingsViewViewModel: ObservableObject{
    @Published var xImageName: String = "xmark"
    @Published var oImageName: String = "circle"
    
    init(){
        
    }
    
}
