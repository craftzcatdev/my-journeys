//
//  NavigationContainer.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import SwiftUI

private struct RouterKey: EnvironmentKey {
    static let defaultValue: Router = Router()
}

extension EnvironmentValues {
    var router: Router {
        get { self[RouterKey.self] }
        set { self[RouterKey.self] = newValue }
    }
}

struct NavigationContainer<Root: View>: View {
    
    @State private var router: Router
    private let root: Root
    
    init(parentRouter: Router? = nil, @ViewBuilder root: () -> Root) {
        let newRouter = Router()
        newRouter.parent = parentRouter
        _router = State(initialValue: newRouter)
        self.root = root()
    }
    
    var body: some View {
        NavigationStack(path: Binding(
            get: { router.pushPath },
            set: { router.pushPath = $0 }
        )) {
            root
                .navigationDestination(for: Destination.Push.self) { destination in
                    // Fix: AnyView để erase 'some View' thành concrete type
                    AnyView(DestinationMapper.view(for: destination))
                }
        }
        .sheet(item: Binding(
            get: { router.activeSheet },
            set: { router.activeSheet = $0 }
        )) { sheetDestination in
            NavigationContainer<AnyView>(parentRouter: router) {
                AnyView(DestinationMapper.view(for: sheetDestination))
            }
        }
        .fullScreenCover(item: Binding(
            get: { router.activeFullScreen },
            set: { router.activeFullScreen = $0 }
        )) { fullScreenDestination in
            NavigationContainer<AnyView>(parentRouter: router) {
                AnyView(DestinationMapper.view(for: fullScreenDestination))
            }
        }
        .environment(\.router, router)
    }
}
