//
//  PawsApp.swift
//  Paws
//
//  Created by Hai Ng. on 14/3/26.
//

import SwiftUI
import SwiftData

@main
struct PawsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}
