//
//  AddReviewScreen.swift
//  Movies
//
//  Created by Hai Ng. on 16/3/26.
//

import SwiftUI
import SwiftData

struct AddReviewScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let movie: Movie
    
    @State private var subject: String = ""
    @State private var description: String = ""
    
    private var isFormValid: Bool {
        !subject.isEmptyOrWhitespace && !description.isEmptyOrWhitespace
    }
    
    var body: some View {
        Form {
            TextField("Subject", text: $subject)
            TextField("Description", text: $description)
        }
        .navigationTitle("Add Review")
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(.glassProminent)
                .tint(.gray)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    let review = Review(subject: subject, body: description)
                    review.movie = movie
                    
                    context.insert(review)
                    
                    do {
                        try context.save()
                        movie.reviews.append(review)
                        dismiss()
                    } catch {
                        print("Failed to save review: \(error.localizedDescription)")
                    }
                }
                .disabled(!isFormValid)
                .buttonStyle(.glassProminent)
                .tint(.blue)
            }
        }
    }
}

//#Preview {
//    AddReviewScreen()
//}
