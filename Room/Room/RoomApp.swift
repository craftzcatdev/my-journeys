//
//  RoomApp.swift
//  Room
//
//  Created by Hai Ng. on 19/3/26.
//

import SwiftUI
import SwiftData

@main
struct RoomsAppApp: App {
    
    init() {
        ValueTransformer.setValueTransformer(UIColorValueTransformer(), forName: NSValueTransformerName("UIColorValueTransformer"))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Room.self])
        }
    }
}
