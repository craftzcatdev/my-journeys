//
//  SearchScreen.swift
//  Ghibli
//
//  Created by Hai Ng. on 12/4/26.
//

import SwiftUI

struct SearchScreen: View {
   
    @State private var text: String = ""

    var body: some View {
        NavigationStack {
            Text("Show search here")
                .searchable(text: $text)
        }
    }
}

#Preview {
    SearchScreen()
}
