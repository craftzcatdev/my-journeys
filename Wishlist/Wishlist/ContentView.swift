//
//  ContentView.swift
//  Wishlist
//
//  Created by Hai Ng. on 13/3/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [Wish]
    
    @State private var isAlertShowing: Bool = false
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack {
            List{
                ForEach (wishes) { wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(wish)
                            }
                        }
                }
            }
            .navigationTitle("Wishlist")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                
                if wishes.isEmpty != true {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(wishes.count) wish\(wishes.count == 1 ? "" : "es")")
                    }
                }
            }
            .alert("Create new wish", isPresented: $isAlertShowing) {
                TextField("New wish", text: $title)
                
                Button{
                    modelContext.insert(Wish(title: title))
                    title = ""
                } label: {
                    Text("Add")
                }
            }
            .overlay{
                if wishes.isEmpty {
                    ContentUnavailableView("No wish added yet", systemImage: "heart.circle", description: Text("No wishes yet. Start adding your wish!"))
                }
            }
        }
    }
}

#Preview("List with sample data") {
    let container = try! ModelContainer(for: Wish.self, configurations:ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(Wish(title: "Master Swift Data"))
    container.mainContext.insert(Wish(title: "Master SwiftUI"))
    container.mainContext.insert(Wish(title: "Master Swift Package Manager"))
    container.mainContext.insert(Wish(title: "Master Swift on Linux"))
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
