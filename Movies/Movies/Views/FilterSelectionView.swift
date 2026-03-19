//
//  FilterSelectionView.swift
//  Movies
//
//  Created by Hai Ng. on 18/3/26.
//

import SwiftUI
import SwiftData

enum FilterOption {
    case title(String)
    case reviewCount(Int)
    case actorCount(Int)
    case genre(Genre)
    case none
}

struct FilterSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var filterSelectionConfig: FilterSelectionConfig
    
    var body: some View {
        Form{
            Section {
                TextField(
                    "Movie title",
                    text: $filterSelectionConfig.movieTitle
                )
                .font(.title.weight(.medium))
                Button {
                    filterSelectionConfig.filter = 
                        .title(filterSelectionConfig.movieTitle)
                    dismiss()
                } label: {
                    Text("Search")
                        .font(.callout.weight(.medium))
                }
                .frame(maxWidth: .infinity ,alignment: .trailing)
                .buttonStyle(.glassProminent)

            } header: {
                Text("Filter by Title")
            }
            
            Section {
                TextField(
                    "Number of reviews: ",
                    value: $filterSelectionConfig.numberOfReview,
                    format: .number
                )
                .keyboardType(.numberPad)
                
                Button {
                    filterSelectionConfig.filter = 
                        .reviewCount(filterSelectionConfig.numberOfReview ?? 1)
                    dismiss()
                } label: {
                    Text("Search")
                        .font(.callout.weight(.medium))
                }
                .frame(maxWidth: .infinity ,alignment: .trailing)
                .buttonStyle(.glassProminent)

            } header: {
                Text("Filter by number of review")
            }
            
            Section {
                TextField(
                    "Number of actors: ",
                    value: $filterSelectionConfig.numberOfActor,
                    format: .number
                )
                .keyboardType(.numberPad)
                
                Button {
                    filterSelectionConfig.filter = 
                        .actorCount(filterSelectionConfig.numberOfActor ?? 1)
                    dismiss()
                } label: {
                    Text("Search")
                        .font(.callout.weight(.medium))
                }
                .frame(maxWidth: .infinity ,alignment: .trailing)
                .buttonStyle(.glassProminent)

            } header: {
                Text("Filter by number of actor")
            }
            
            Section {
                Picker(
                    selection: $filterSelectionConfig.genre,
                    label: Text("Select a Genre")
                ) {
                    ForEach(Genre.allCases) { genre in
                        Text(genre.title).tag(genre)
                    }
                }
                .onChange(of: filterSelectionConfig.genre) {
                    filterSelectionConfig.filter = 
                        .genre(filterSelectionConfig.genre)
                    dismiss()
                }
            } header: {
                Text("Filter by genre")
                    .textCase(.uppercase)
            }
        }
    }
}

#Preview {
    FilterSelectionView(
        filterSelectionConfig: .constant(FilterSelectionConfig())
    )
}

