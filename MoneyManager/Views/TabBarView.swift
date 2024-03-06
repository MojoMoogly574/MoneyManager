//
//  HomeView.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI

import SwiftUI

struct TabBarView: View {
    // MARK:  PROPERTIES
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    /// App Lock Properties
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    /// Active Tab and Tab Properties
    @State private var activeTab: Tab = .transactions
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    
    
    var body: some View {
        ZStack{
           
            LockView(lockType: .biometric, lockPin: "", isEnabled: isAppLockEnabled, lockWhenAppGoesBackground: lockWhenAppGoesBackground) {
                TabView(selection: $activeTab) {
                    DashboardView()
                        .tag(Tab.dashboards)
                    
                    TransactionsView()
                        .tag(Tab.transactions)
                    
                    SearchView()
                        .tag(Tab.search)

                    BudgetsView()
                        .tag(Tab.budget)
                    
                    SettingsView()
                        .tag(Tab.settings)
                }
            }
            CustomTabBar() .tint(appTint)
                .padding(.horizontal, 10)
                .padding(.top, 760)
                .sheet(isPresented: $isFirstTime) {
                    IntroScreen()
                }
                               .interactiveDismissDisabled()
                   }
                   }
    /// Custom Tab Bar
    /// With More Easy Customization
    @ViewBuilder
    func CustomTabBar(_ tint: Color = .blue, _ inactiveTint: Color = .primary) -> some View {
        /// Moving all the Remaining Tab Item's to Bottom
        HStack(alignment: .bottom, spacing: 0) {
            Spacer()
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: appTint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab,
                    position: $tabShapePosition
                )
            }
        }
        .background(content: {
            TabShape(midpoint: tabShapePosition.x)
                .fill(.clear)
                .font(.footnote)
                .ignoresSafeArea()
            /// Adding Blur + Shadow
            /// For Shape Smoothening
                .shadow(color: tint.opacity(0.1), radius: 5, x: 1, y: -5)
                .blur(radius: 2)
            //   .padding(.top, 25)
        })
        .padding(.horizontal)
        /// Adding Animation
        .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
    
}

/// Tab Bar Item
struct TabItem: View {
var tint: Color
var inactiveTint: Color
var tab: Tab
var animation: Namespace.ID
@Binding var activeTab: Tab
@Binding var position: CGPoint

/// Each Tab Item Position on the Screen
@State private var tabPosition: CGPoint = .zero
var body: some View {
    VStack(spacing: 5) {
        Image(systemName: tab.systemImage)
            .font(.title2)
            .foregroundColor(activeTab == tab ? .primary : inactiveTint)
        /// Increasing Size for the Active Tab
            .frame(width: activeTab == tab ? 45 : 30, height: activeTab == tab ? 45 : 30)
            .background {
                if activeTab == tab {
                    Circle()
                        .fill(tint.gradient)
                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                }
            }
        
        Text(tab.rawValue)
            .font(.caption)
            .foregroundColor(activeTab == tab ? tint : .primary)
    }
    .frame(maxWidth: .infinity)
    .contentShape(Rectangle())
    .viewPosition(completion: { rect in
        tabPosition.x = rect.midX
        
        /// Updating Active Tab Position
        if activeTab == tab {
            position.x = rect.midX
        }
    })
    .onTapGesture {
        activeTab = tab
        
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3)) {
            position.x = tabPosition.x
        }
    }
}
}

#Preview {
TabBarView()
}
