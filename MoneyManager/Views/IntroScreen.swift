//
//  IntroScreen.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI

struct IntroScreen: View {
    /// Visibility Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    var body: some View {
        VStack(spacing: 15) {
            Text("What's New in \nWealth Builder")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)
                .foregroundStyle(.primary)
            
            ///Main Points View
            VStack(alignment: .leading, spacing: 25, content: {
                PointView(symbol: "dollarsign", title: "Transactions", subTitle: "Keep track of your earnings and transactions.")
                PointView(symbol: "filemenu.and.selection", title: "Budgets", subTitle: "Structure your fiscal health, utilizing smart budgets and bill reminders.")

                PointView(symbol: "chart.bar.fill", title: "Visual Charts", subTitle: "View your transactions using eye-catching graphic representations.")
                
                PointView(symbol: "magnifyingglass", title: "Advance Filters", subTitle: "Find the transactions you want by advance search and filtering.")
                
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            Spacer()
            Button(action: {
                isFirstTime = false
                HapticManager.notification(type: .success)
            }, label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 350)
                    .padding(.vertical, 14)
                    .background(.colorGrey.gradient, in: .rect(cornerRadius: 12))
                    .contentShape(.rect)
                    .padding(.bottom, 80)
            })
        }
        .background(.blue.gradient, in: .rect(cornerRadius: 12))
        .ignoresSafeArea()
    }
    /// Point View
    @ViewBuilder
    func PointView(symbol: String, title: String, subTitle: String) -> some View {
        HStack(spacing: 20) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(.colorBlack.gradient)
                .frame(width: 45)
            
            VStack(alignment: .leading, spacing: 6, content: {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.colorBlack)
                
                Text(subTitle)
                    .font(.callout)
                    .foregroundStyle(.primary)
            })
        }
    }
}

#Preview {
    IntroScreen()
}
