//
//  TransactionCardView.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI
import WidgetKit

struct TransactionCardView: View {
    @Environment(\.modelContext) private var context
    var transaction: Transaction
    var showsCategory: Bool = false
    var body: some View {
        SwipeAction(cornerRadius: 10, direction: .trailing) {
            HStack(spacing: 12) {
                Text("\(String(transaction.title.prefix(1)))")
                    .fontDesign(.serif)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(transaction.color.gradient, in: .circle)
                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(transaction.title)
                        .foregroundStyle(.primary)
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .font(.title2)
                    
                    if !transaction.remarks.isEmpty {
                        Text(transaction.remarks)
                            .fontDesign(.serif)
                            .font(.title3)
                            .foregroundStyle(Color.primary.secondary)
                    }
                    
                    Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    if showsCategory {
                        Text(transaction.category)
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .foregroundStyle(.white)
                            .background(transaction.category == Category.income.rawValue ? Color.green.gradient : Color.red.gradient, in: .capsule)
                    }
                })
                .lineLimit(1)
                .hSpacing(.leading)
                
                Text(currencyString(transaction.amount, allowedDigits: 2))
                    .fontWeight(.semibold)
            }
       //     clipShape(RoundedRectangle(cornerRadius: 10.0))
            .padding(10)
            .background(.themeBG, in: .rect(cornerRadius: 10))
            .padding(.horizontal, 5)
      //      .padding(.vertical, 10)
           
        } actions: {
            Action(tint: .red, icon: "trash") {
                context.delete(transaction)
     //           WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}

