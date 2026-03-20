//
//  GardenGreensApp.swift
//  GardenGreens
//
//  Created by Mohammad Azam on 9/28/23.
//

import SwiftUI

@main
struct GardenGreensApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }.modelContainer(for: [Vegetable.self])
    }
}
