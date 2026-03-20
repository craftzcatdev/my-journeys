//
//  NoteListScreen.swift
//  GardenGreens
//
//  Created by Mohammad Azam on 9/28/23.
//

import SwiftUI
import SwiftData

struct NoteListScreen: View {
    
    let vegetable: Vegetable
    
    @Query private var notes: [Note]
    
    @State private var text: String = ""
    @Environment(\.modelContext) private var context
    
    private var notesByVegetable: [Note] {
        notes.filter { $0.vegetable!.id == vegetable.id }
    }
    
    var body: some View {
        VStack {
            TextField("Note text", text: $text)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    print("done")
                    let note = Note(text: text)
                    note.vegetable = vegetable
                }
            
            List(notesByVegetable) { note in
                Text(note.text)
            }
            
            Spacer()
        }.padding()
        .navigationTitle(vegetable.name)
    }
}


struct NoteListContainerScreen: View {
    
    @Query private var vegetables: [Vegetable]
    
    var body: some View {
        NoteListScreen(vegetable: vegetables[0])
    }
}

#Preview { @MainActor in
    NavigationStack {
        NoteListContainerScreen()
            .modelContainer(previewContainer)
    }
}
