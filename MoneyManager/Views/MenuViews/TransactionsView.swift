//
//  TransactionsView.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI
import SwiftData

struct TransactionsView: View {
    //MARK:  PROPERTIES
    /// User Properties
    @AppStorage("userName") private var userName: String = ""
    /// View Properties
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var showFilterView: Bool = false
    @State private var addTransaction: Bool = false
    @State private var showSideMenu = false
    @State private var selectedCategory: Category = .expense
    @State private var selectedTransaction: Transaction?
    @State private var selectedTab = 0
    
    /// For Animation
    @Namespace private var animation
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            NavigationStack{
                ZStack{
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                            //MARK: BODY
                            Section {
                                /// DATE RANGE FILTER BUTTON
                                Button {
                                    showFilterView = true
                                    HapticManager.notification(type: .success)
                                } label: {
                                    Text(" Select Range:  \(format(date: startDate,format: "dd MMM yy"))   -   \(format(date: endDate,format: "dd MMM yy"))")
                                        .font(.callout)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black)
                                        .padding(8)
                                }
                                .hSpacing(.leading)
                                .background {///date range button rectangle
                                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .fill(.colorTitanium.gradient)
                                        .shadow(color: .primary, radius: 4, x: 2, y: 2)
                                }
                                .padding(.horizontal)
                                Divider()
                                FilterTransactionsView(startDate: startDate, endDate: endDate) { transactions in
                                    /// HEADER CARD VIEW
                                    CardView(
                                        income: total(transactions, category: .income),
                                        expense: total(transactions, category: .expense),
                                        savings: total(transactions, category: .savings),
                                        investments: total(transactions, category: .investment)
                                    )
                                }
                                    ///  CATEGORY SEGMENTED PICKER
                                    Picker("", selection: $selectedCategory) {
                                        ForEach(Category.allCases, id: \.rawValue) { category in
                                            Text("\(category.rawValue)")
                                                .tag(category)
                                        }
                                    }
                                    .pickerStyle(.segmented)
                                    .padding(.horizontal, 5)
                                Divider()
                                    .background(.primary)
                                ///FILTER TRANSACTION VIEW
                                FilterTransactionsView(startDate: startDate, endDate: endDate, category: selectedCategory) { transactions in
                                    ForEach(transactions) { transaction in
                                        //TRANSACTION CARD VIEW
                                        TransactionCardView(transaction: transaction)
                                            .onTapGesture {
                                                selectedTransaction = transaction
                                            }
                                    }
                                }
                                .animation(.none, value: selectedCategory)
                            } header: {
                                //MARK:  HEADER VIEW
                                HStack{
                                    VStack(alignment: .trailing, content: {
                                        Text(" Welcome!")
                                            .font(.title.bold())
                                        if !userName.isEmpty {
                                            Text(userName)
                                                .font(.callout)
                                                .foregroundStyle(.secondary)
                                        }
                                    })  .hSpacing(.center)
                                        .visualEffect { content, geometryProxy in
                                            content
                                                .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .center)
                                        }
                                }
                                .padding(.horizontal, 2)
                                .padding(.bottom, userName.isEmpty ? 10 : 5)
                            }
                            .ignoresSafeArea()
                            .padding(.horizontal)
                            .background {
                                VStack(spacing: 0) {
                                    Rectangle()
                                        .fill(.clear)
                                }
                                .visualEffect { content, geometryProxy in
                                    content
                                        .opacity(headerBGOpacity(geometryProxy))
                                }
                                .padding(.top, -(safeArea.top + 15))
                            }
                        }
                    }
                    .blur(radius:showFilterView ? 8 : 0)
                    .disabled(showFilterView)
                    .navigationDestination(item: $selectedTransaction) { transaction in
                        EditTransactionView(editTransaction: transaction)///pass transaction to editview
                    }
                    //ADD TRANSACTION BUTTON 
                    VStack{
                        Spacer()
                        Button {
                            addTransaction = true
                            HapticManager.notification(type: .success)
                        } label: {
                            Image(systemName: "plus")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 45, height: 45)
                                .background(appTint.gradient, in: .circle)
                                .contentShape(.circle)
                        }
                        .sheet(isPresented: $addTransaction) {
                            AddTransactionView()
                                .presentationDetents([.large])
                        }
                    }
                }
            }
            //MARK: SHOW DATE FILTER VIEW
            .overlay {
                if showFilterView {
                    DateFilterView(start: startDate, end: endDate, onSubmit: {start, end in
                        startDate = start
                        endDate = end
                        showFilterView = false
                    }, onClose: {
                        showFilterView = false
                    })
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.snappy, value: showFilterView)
        }
    }
    //MARK:  FUNCTIONS
    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        let progress = minY / screenHeight
        let scale = (min(max(progress, 0), 1)) * 0.6
        return 1 + scale
    }
}

#Preview {
    ContentView()
}
