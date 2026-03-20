//
//  PreviewContainer.swift
//  GardenGreens
//
//  Created by Mohammad Azam on 9/28/23.
//

import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    
    do {
        let container = try ModelContainer(for: Vegetable.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        SampleData.vegetables.forEach { vegetable in
            container.mainContext.insert(vegetable)
        }
        
        return container
    } catch {
        fatalError("Failed to create container.")
    }
    
}()

struct SampleData {
    static let vegetables: [Vegetable] = {
        return [Vegetable(name: "Tomato"), Vegetable(name: "Turnip"), Vegetable(name: "Onion"), Vegetable(name: "Pepper")]
    }()
}
