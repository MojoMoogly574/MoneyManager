//
//  CardView.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI

struct CardView: View {
    var income: Double
    var expense: Double
    var savings: Double
    var investments: Double
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.background)
            VStack(spacing: 0) {
                HStack(spacing: 5) {
                    Text("Balance Remaining:      \(currencyString(income - savings - expense - investments))")
                        .font(.title2.bold())
                        .fontDesign(.serif)
                        .foregroundStyle(expense + savings + investments > income ? .red : .colorGreen)
                        .padding(.top, 10)
                }
                .hSpacing(.centerLastTextBaseline)
                Divider().padding()
                HStack(spacing: 0) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        ZStack{
                            VStack(alignment: .leading, spacing: 4) {
                                Text(category.rawValue)
                                    .font(.callout)
                                    .foregroundStyle(.colorGrey)
                                if category == .income {
                                    Text(currencyString(category == .income ? income : expense,  allowedDigits: 0))
                                        .font(.callout)
                                        .fontDesign(.serif)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.primary)
                                }
                                if category == .expense {
                                    Text(currencyString(category == .expense ? expense : savings,  allowedDigits: 0))
                                        .font(.callout)
                                        .fontDesign(.serif)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.primary)
                                }
                                if category == .savings {
                                    Text(currencyString(category == .savings ? savings : expense,  allowedDigits: 0))
                                        .font(.callout)
                                        .fontDesign(.serif)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.primary)
                                }
                                if category == .investment {
                                    Text(currencyString(category == .investment ? investments : savings,  allowedDigits: 0))
                                        .font(.callout)
                                        .fontDesign(.serif)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.primary)
                                }
                            }
                        }.hSpacing(.leading)
                    }
                    .hSpacing(.center)
                }
                .padding([.horizontal, .bottom], 15)
                .padding(.top, 15)
                .padding(7)
            }
            .background(.themeBG.gradient)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
#Preview {
    CardView(income: 1247, expense: 67, savings: 900, investments: 45)
    }

