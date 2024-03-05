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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
            
            VStack(spacing: 0) {
                
                HStack(spacing: 5) {
                    Text("Balance Remaining:         \(currencyString(income - savings - expense - investments))")
                        .font(.title3.bold())
                        .foregroundStyle(expense + savings + investments > income ? .colorRed : .colorGreen)
                }.hSpacing(.centerLastTextBaseline)
                Divider().padding()
                HStack(spacing: 0) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        ZStack{
                            VStack(alignment: .leading, spacing: 4) {
                                Text(category.rawValue)
                                    .font(.caption)
                                    .foregroundStyle(.colorGrey)
                                
                                if category == .income {
                                    Text(currencyString(category == .income ? income : expense,  allowedDigits: 0))
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.primary)
                                }
                                
                                if category == .expense {
                                    Text(currencyString(category == .expense ? expense : savings,  allowedDigits: 0))
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.primary)
                                }
                                if category == .savings {
                                    Text(currencyString(category == .savings ? savings : expense,  allowedDigits: 0))
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.primary)
                                }
                                if category == .investment {
                                    Text(currencyString(category == .investment ? investments : savings,  allowedDigits: 0))
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.primary)
                                }
                            }
                        }.hSpacing(.leading)
                    }
                    .hSpacing(.center)
                    
                }
                .padding([.horizontal, .bottom], 25)
                .padding(.top, 15)
            }
            .background(.themeBG.gradient)
         
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
#Preview {
   TransactionsView()
    }

