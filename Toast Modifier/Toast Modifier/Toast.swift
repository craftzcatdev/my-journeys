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
        VStack {
        
            Spacer()
            
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
            
            Spacer()
            
            ToastView(text: text)
                .offset(y: showToast ? 0 : 100)

        }
        .padding()
    }
}

struct ToastView: View {
    let text: String
    let color: Color
    let textColor: Color
    
    init(
        text: String,
        color: Color = .black.opacity(0.8),
        textColor: Color = .white
    ) {
        self.text = text
        self.color = color
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .foregroundStyle(textColor)
            .background(
                Capsule()
                    .fill(color)
            )
            .shadow(color: color, radius: 5, x: 0, y: 3 )
    }
}


#Preview {
    Toast(text: "Toast is Delicius")
}
