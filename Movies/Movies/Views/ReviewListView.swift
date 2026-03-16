//
//  ReviewListView.swift
//  Movies
//
//  Created by Hai Ng. on 16/3/26.
//

import SwiftUI
import SwiftData

struct ReviewListView: View {
    
    let reviews: [Review]
    @Environment(\.modelContext) private var context
    
    private func deleteReview(indexSet: IndexSet) {
        indexSet.forEach { index in
            let review = reviews[index]
            context.delete(review)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(reviews) { review in
                VStack(alignment: .leading) {
                    Text(review.subject)
                        .font(.title2.weight(.medium))
                    Text(review.body)
                        .font(.subheadline.weight(.light))
                }
            }
            .onDelete(perform: deleteReview)
            .labelStyle(.iconOnly)
        }
    }
}

#Preview {
    ReviewListView(reviews: [Review(subject: "Subject", body: "Body")])
        .modelContainer(for: [Review.self, Movie.self], inMemory: true)
}
