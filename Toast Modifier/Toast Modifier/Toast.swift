//
//  ContentView.swift
//  Toast Modifier
//
//  Created by Hai Ng. on 5/4/26.
//

import SwiftUI

struct Toast: View {
    
    @State private var showToast: Bool = true
    
    var showToastPrompt: String {
        showToast ? "Hide Toast" : "Show Toast"
    }
    
    let text: String
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                showToast.toggle()
            }
        } label: {
            Text(showToastPrompt)
        }
        .buttonStyle(.glassProminent)
        .saturation(showToast ? 0.9 : 1)
        .padding()
        .toast(text: text, showToast: $showToast)
    }
}

#Preview {
    Toast(text: "Toast is Delicius")
}
