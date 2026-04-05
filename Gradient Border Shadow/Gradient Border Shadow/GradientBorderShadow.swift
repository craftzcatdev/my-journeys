//
//  ContentView.swift
//  Gradient Border Shadow
//
//  Created by Hai Ng. on 5/4/26.
//

import SwiftUI

struct GradientBorderShadow: View {
    var body: some View {
        Text("Hello, world!")
            .font(.largeTitle)
            .padding()
            .gradientBorderAndShadow(
                gradient: LinearGradient(
                    colors: [.red, .blue],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

struct RoundedCornerGradientShadow: ViewModifier {
    let radius: CGFloat
    let gradient: LinearGradient
    let shadowColor: Color
    let shadowRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .stroke(gradient, lineWidth: 4)
            }
            .shadow(color: shadowColor, radius: shadowRadius)
    }
}

extension View {
    func gradientBorderAndShadow(gradient: LinearGradient, borderWidth: CGFloat = 3.0) -> some View {
        self.modifier(
            RoundedCornerGradientShadow(
                radius: 12,
                gradient: gradient,
                shadowColor: .gray.opacity(0.5),
                shadowRadius: 6
            )
        )
    }
}

#Preview {
    GradientBorderShadow()
}
