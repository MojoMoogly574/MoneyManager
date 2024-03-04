//
//  MenuModel.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI

// Menu Data...

class MenuViewModel: ObservableObject{
    
    //Default...
    @Published var selectedMenu = "Catalogue"
    
    // Show...
    @Published var showDrawer = false
}
