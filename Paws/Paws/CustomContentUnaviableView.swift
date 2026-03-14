//
//  CustomContentUnaviableView.swift
//  Paws
//
//  Created by Hai Ng. on 14/3/26.
//

import SwiftUI

struct CustomContentUnaviableView: View {
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        ContentUnavailableView {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 96)
                
            Text(title)
                .font(.largeTitle)
                .bold()
        } description: {
            Text(description)
        }
        .foregroundColor(.secondary)
    }
}

#Preview {
    CustomContentUnaviableView(
        icon: "cat.circle",
        title: "No photos",
        description: "Add a photo to get started"
    )
}
