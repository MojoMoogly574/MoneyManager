//
//  ExpensesList.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI

struct ExpensesList: View {
    @Environment(\.modelContext) private var context
    let month: Date
    /// View Properties
    @State private var selectedTransaction: Transaction?
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                Section {
                    FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .income) { transactions in
                        ForEach(transactions) { transaction in
                            TransactionCardView(transaction: transaction)
                                .onTapGesture {
                                    selectedTransaction = transaction
                                }
                        }
                    }
                } header: {
                    Text("Income")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                }
                
                Section {
                    FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .expense) { transactions in
                        ForEach(transactions) { transaction in
                            TransactionCardView(transaction: transaction)
                                .onTapGesture {
                                    selectedTransaction = transaction
                                }
                        }
                    }
                } header: {
                    Text("Expense")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                }
            }
            .padding(15)
        }
        .background(.gray.opacity(0.15))
        .navigationTitle(format(date: month, format: "MMM yy"))
        .navigationDestination(item: $selectedTransaction) { transaction in
            TransactionsView()
        }
    }
}

