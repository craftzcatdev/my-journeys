//
//  Grocery_ListApp.swift
//  Grocery List
//
//  Created by Hai Ng. on 13/3/26.
//

import SwiftUI
import SwiftData

@main
struct Grocery_ListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
