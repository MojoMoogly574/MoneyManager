//
//  Tab.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/5/24.
//

import SwiftUI

///Current Active Tabs
enum Tab: String, CaseIterable {
    case dashboards = "DashBoards"
    case transactions = "Transactions"
    case search = "Search"
    case budget = "Budget"
    case settings = "Settings"
    
    var systemImage: String {
        switch self {
        case .dashboards:
        return "chart.bar.doc.horizontal.fill"
        case .transactions:
            return "dollarsign"
        case .search:
            return "magnifyingglass"
        case .budget:
            return "list.bullet.rectangle.fill"
        case .settings:
          return "gear"
        }
    }
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}




