//
//  AddMovieView.swift
//  Movies
//
//  Created by Hai Ng. on 15/3/26.
//

import SwiftUI
import SwiftData

struct AddMovieScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var year: Int?
    
    private var isFormvalid: Bool {
        !title.isEmptyOrWhitespace && year != nil
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year ,format: .number)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close"){
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save"){
                    guard let year = year else { return }
                    
                    let movie = Movie(title: title, year: year)
                    context.insert(movie)
                    
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                .disabled(!isFormvalid)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMovieScreen()
            .modelContainer(for: [Movie.self])
    }
}
