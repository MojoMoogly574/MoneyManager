//
//  Drawer.swift
//  MoneyManager
//
//  Created by J. DeWeese on 3/4/24.
//

import SwiftUI

struct Drawer: View {
    
    @EnvironmentObject var menuData: MenuViewModel
    
    // Animation...
    var animation: Namespace.ID
    
    var body: some View {
        
        VStack{
            HStack{
                Image("NullProfile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                Spacer()
                // Close Button..
                if menuData.showDrawer{
                    DrawerCloseButton(animation: animation)
                }
            }
            .padding()
            VStack(alignment: .leading, spacing: 10, content: {
                Text("Hello")
                    .font(.title3)
                Text("Joseph DeWeese")
                    .font(.title2)
                    .fontWeight(.heavy)
            })
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top,5)
            
            // Menu Buttons....
            
            VStack(spacing: 22){
                MenuButton(name: "Dashboard", image: "chart.bar.doc.horizontal.fill", selectedMenu: $menuData.selectedMenu,animation: animation)
                
                MenuButton(name: "Transactions", image: "dollarsign", selectedMenu: $menuData.selectedMenu,animation: animation)
                
                MenuButton(name: "Search", image: "magnifyingglass", selectedMenu: $menuData.selectedMenu,animation: animation)
                
                MenuButton(name: "Budgets", image: "list.bullet.rectangle.fill", selectedMenu: $menuData.selectedMenu,animation: animation)
                    
                MenuButton(name: "Settings", image: "gear", selectedMenu: $menuData.selectedMenu,animation: animation)
            }
            .navigationBarBackButtonHidden(true)
            .padding(.leading)
            .frame(width: 250, alignment: .leading)
            .padding(.top,30)
            
            Divider()
                .background(Color.white)
                .padding(.top,30)
                .padding(.horizontal,25)
            
            Spacer()
            
            MenuButton(name: "Sign Out", image: "rectangle.righthalf.inset.fill.arrow.right", selectedMenu: .constant(""),animation: animation)
                .padding(.bottom)
        }
        // Default Size...
        .frame(width: 250)
        .background(
            Color(appTint)
                .ignoresSafeArea(.all, edges: .vertical)
        )
    }
}

struct Drawer_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView().navigationBarBackButtonHidden(true)
    }
}

// Close Button....

struct DrawerCloseButton: View {
    
    @EnvironmentObject var menuData: MenuViewModel
    var animation: Namespace.ID
    
    var body: some View{
        
        Button(action: {
            withAnimation(.easeInOut){
                menuData.showDrawer.toggle()
                HapticManager.notification(type: .success)
            }
        }, label: {
            
            VStack(spacing: 5){
                
                Capsule()
                    .fill(menuData.showDrawer ? Color.white : Color.white)
                    .frame(width: 35, height: 3)
                    .rotationEffect(.init(degrees: menuData.showDrawer ? -50 : 0))
                // Adjusting Like X....
                    // Based On Trail And Error...
                    .offset(x: menuData.showDrawer ? 2 : 0, y: menuData.showDrawer ? 9 : 0)
                
                VStack(spacing: 5){
                    
                    Capsule()
                        .fill(menuData.showDrawer ? Color.white : Color.white)                        
                        .frame(width: 35, height: 3)
                    
                    Capsule()
                        .fill(menuData.showDrawer ? Color.white : Color.white)                       
                        .frame(width: 35, height: 3)
                    // Moving This View TO Hide...
                        .offset(y: menuData.showDrawer ? -8 : 0)
                }
                // Rotating Like XMark....
                .rotationEffect(.init(degrees: menuData.showDrawer ? 50 : 0))
            }
        }) 
        // Making It Little Small...
        .scaleEffect(0.8)
        .matchedGeometryEffect(id: "MENU_BUTTON", in: animation)
    }
}
