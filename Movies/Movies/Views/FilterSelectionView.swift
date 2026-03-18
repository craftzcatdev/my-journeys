//
//  FilterSelectionView.swift
//  Movies
//
//  Created by Hai Ng. on 18/3/26.
//

import SwiftUI

enum FilterOption {
    case title(String)
    case reviewCount(Int)
    case actorCount(Int)
    case none
}

struct FilterSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var movieTitle: String = ""
    @State private var numberOfReview: Int?
    @State private var numberOfActor: Int?
    
    @Binding var filterOption: FilterOption
    
    var body: some View {
        Form {
            Section("Filter by Title") {
                TextField("Movie title", text: $movieTitle)
                    .font(.title.weight(.medium))
                Button {
                    filterOption = .title(movieTitle)
                    dismiss()
                } label: {
                    Text("Search")
                        .font(.callout.weight(.medium))
                }
                .frame(maxWidth: .infinity ,alignment: .trailing)
                .buttonStyle(.glassProminent)

            }
            
            Section("Filter by number of review") {
                TextField("Number of reviews: ", value: $numberOfReview, format: .number)
                    .keyboardType(.numberPad)
                
                Button {
                    filterOption = .reviewCount(numberOfReview ?? 1)
                    dismiss()
                } label: {
                    Text("Search")
                        .font(.callout.weight(.medium))
                }
                .frame(maxWidth: .infinity ,alignment: .trailing)
                .buttonStyle(.glassProminent)

            }
            
            Section("Filter by number of actor") {
                TextField("Number of actors: ", value: $numberOfActor, format: .number)
                    .keyboardType(.numberPad)
                
                Button {
                    filterOption = .actorCount(numberOfActor ?? 1)
                    dismiss()
                } label: {
                    Text("Search")
                        .font(.callout.weight(.medium))
                }
                .frame(maxWidth: .infinity ,alignment: .trailing)
                .buttonStyle(.glassProminent)

            }
        }
    }
}

#Preview {
    FilterSelectionView(filterOption: .constant(.title("Batman")))
}
