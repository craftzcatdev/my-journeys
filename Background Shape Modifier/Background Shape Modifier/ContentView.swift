//
//  ContentView.swift
//  Background Shape Modifier
//
//  Created by Hai Ng. on 5/4/26.
//

import SwiftUI

struct BackgroundShapeModifier<S>: ViewModifier where S: Shape{
    var color: Color
    var shape: S
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(shape)
    }
}

extension View {
    func backgroundShape<S: Shape> (color: Color, shape: S) -> some View {
        self
            .modifier(
                BackgroundShapeModifier(color: color, shape: shape)
            )
    }
}

struct ContentView: View {
    let text: String = "Hello"
    var body: some View {
        VStack {
            Text(text)
                .backgroundShape(color: .blue, shape: .rect(cornerRadius: 30))
            
            
            Text(text)
                .backgroundShape(color: .purple, shape: UnevenRoundedRectangle(
                    topLeadingRadius: 30,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 0,
                    style: .continuous
                ))
                
            Text(text)
                .backgroundShape(color: .red, shape: Circle())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
