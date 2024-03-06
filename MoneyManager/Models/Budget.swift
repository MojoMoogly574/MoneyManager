//
//  Budget.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/5/24.
//


import Foundation
import SwiftUI
import SwiftData

@Model
class Budget {
    var budgetName: String
    var budgetDesc: String
    var budgetAmount: Double
    var transactions: [Transaction]?
    
    init(
        budgetName: String,
        budgetDesc: String,
        budgetAmount: Double
    ) {
        self.budgetName = budgetName
        self.budgetDesc = budgetDesc
        self.budgetAmount = budgetAmount
    }
}
