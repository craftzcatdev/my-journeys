//
//  NavigationButton.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import SwiftUI

// Thay thế NavigationLink — hoạt động với MỌI loại transition
struct NavigationButton<Label: View>: View {
    
    @Environment(\.router) private var router
    
    let destination: NavigationButtonDestination
    let label: Label
    
    init(push: Destination.Push, @ViewBuilder label: () -> Label) {
        self.destination = .push(push)
        self.label = label()
    }
    
    init(sheet: Destination.Sheet, @ViewBuilder label: () -> Label) {
        self.destination = .sheet(sheet)
        self.label = label()
    }
    
    init(fullScreen: Destination.FullScreen, @ViewBuilder label: () -> Label) {
        self.destination = .fullScreen(fullScreen)
        self.label = label()
    }
    
    var body: some View {
        Button {
            switch destination {
            case .push(let d):       router.push(d)
            case .sheet(let d):      router.presentSheet(d)
            case .fullScreen(let d): router.presentFullScreen(d)
            }
        } label: {
            label
        }
    }
}

enum NavigationButtonDestination {
    case push(Destination.Push)
    case sheet(Destination.Sheet)
    case fullScreen(Destination.FullScreen)
}
