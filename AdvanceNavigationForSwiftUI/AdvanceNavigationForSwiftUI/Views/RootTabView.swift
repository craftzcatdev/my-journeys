//
//  RootTabView.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import SwiftUI

struct RootTabView: View {
    
    // Root router quản lý tab selection
    @State private var rootRouter = Router()
    
    var body: some View {
        TabView(selection: Binding(
            get: { rootRouter.selectedTab },
            set: { rootRouter.selectedTab = $0 }
        )) {
            // Mỗi tab có NavigationContainer riêng với router con
            NavigationContainer(parentRouter: rootRouter) {
                HomeView()
            }
            .tabItem { Label("Home", systemImage: "house") }
            .tag(0)
            
            NavigationContainer(parentRouter: rootRouter) {
                SearchView()
            }
            .tabItem { Label("Search", systemImage: "magnifyingglass") }
            .tag(1)
            
            NavigationContainer(parentRouter: rootRouter) {
                FavoriteView()
            }
            .tabItem { Label("Favorites", systemImage: "heart") }
            .tag(2)
        }
        // Deep link handler — chỉ cần ở đây, 1 lần duy nhất
        .onOpenURL { url in
            handleDeepLink(url)
        }
    }
    
    private func handleDeepLink(_ url: URL) {
        // movieapp://movie/tt0468569
        // movieapp://actor/nm0000288/Christian%20Bale
        guard (url.host.map({ "/" + $0 }) ?? url.path as String?) != nil else { return }
        let fullPath = (url.host ?? "") + url.path
        
        if let destination = Router.destination(fromDeepLink: fullPath) {
            // Navigate đến Home tab trước
            rootRouter.selectedTab = 0
            // Sau đó push destination vào router (đơn giản hóa cho demo)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                rootRouter.push(destination)
            }
        }
    }
}

