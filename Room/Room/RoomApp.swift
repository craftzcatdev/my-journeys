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
        // FIX: `EXC_BAD_ACCESS` tại `swift::nameForMetadata`
        // Register TRƯỚC — đảm bảo transformer có sẵn khi ModelContainer khởi tạo
        UIColorValueTransformer.register()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Room.self])
        }
    }
}
