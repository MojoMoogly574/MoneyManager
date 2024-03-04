//
//  AppConstants.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI

@Observable
class UIConstants {
    static let shared = UIConstants()
    
    var appTint: String = UserDefaults.standard.string(forKey: "appTint") ?? "Red"
    
    var tintColor: Color {
        return tints.first { $0.color == appTint }?.value ?? .blue
    }
}

