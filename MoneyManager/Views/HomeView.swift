//
//  HomeView.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var context
    // Hiding tab Bar...
    init() {
        UITabBar.appearance().isHidden = true
    }
    @StateObject var menuData = MenuViewModel()
    @Namespace var animation
    
    var body: some View {
        
        HStack(spacing: 0){
            /// Drawer...
            Drawer(animation: animation)
            /// Main View...
            TabView(selection: $menuData.selectedMenu){
                
                TransactionsView()
                    .tag("Transactions")
                
                DashboardView()
                    .tag("Dashboard")
                
                SearchView()
                    .tag("Search")
                
                BudgetsView()
                    .tag("Budgets")
                
                SettingsView()
                    .tag("Settings")
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .navigationBarBackButtonHidden(true)
        // Max Frame...
        .frame(width: UIScreen.main.bounds.width)
        // Moving View....
        // 250/2 => 125....
        .offset(x: menuData.showDrawer ? 125 : -125)
//        .overlay(
//            ZStack{
//                if !menuData.showDrawer  {
//                    
//                    DrawerCloseButton(animation: animation)
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .frame(width: 45, height: 45)
//                        .background(appTint.gradient, in: .circle)
//                        .contentShape(.circle)
//                        .padding(.horizontal)
//                }
//            },
//            alignment: .topLeading
//        )
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
