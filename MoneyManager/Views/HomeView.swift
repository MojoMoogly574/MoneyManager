//
//  HomeView.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI

struct HomeView: View {
    
    // Hiding tab Bar...
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @StateObject var menuData = MenuViewModel()
    
    @Namespace var animation
    
    var body: some View {
        
        HStack(spacing: 0){
            // Drawer And Main View...
            
            // Drawer...
            Drawer(animation: animation)
            
            // Main View...
            
            TabView(selection: $menuData.selectedMenu){
                
                TransactionsView()
                    .tag("Transactions")

                ProfileView()
                    .tag("Profile")
                
                DashboardView()
                    .tag("Dashboard")
                
                SearchView()
                    .tag("Search")
                
                SettingsView()
                    .tag("Settings")
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        // Max Frame...
        .frame(width: UIScreen.main.bounds.width)
        // Moving View....
        // 250/2 => 125....
        .offset(x: menuData.showDrawer ? 125 : -125)
        .overlay(
        
            ZStack{
                
                if !menuData.showDrawer{
                    
                    DrawerCloseButton(animation: animation)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 45, height: 45)
                        .background(appTint.gradient, in: .circle)
                        .contentShape(.circle)
                        .padding(.horizontal)
                }
            },
            alignment: .topLeading
        )
        
        // Setting As Environment Object....
        // For Avoiding Re-Declarations...
        .environmentObject(menuData)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
