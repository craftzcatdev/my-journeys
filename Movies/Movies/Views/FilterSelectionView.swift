//
//  FilterSelectionView.swift
//  Movies
//
//  Created by Hai Ng. on 18/3/26.
//

import SwiftUI

enum FilterOption {
    case title(String)
    case none
}

struct FilterSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var movieTitle: String = ""
    
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
        }
    }
}

#Preview {
    FilterSelectionView(filterOption: .constant(.title("Batman")))
}
