//
//  ToastView.swift
//  Toast Modifier
//
//  Created by Hai Ng. on 5/4/26.
//


import SwiftUI

struct ToastView: View {
    let text: String
    @Binding var showToast: Bool
    
    var body: some View {
        TextWithBackgroundView(text: text)
            .offset(y: showToast ? 0 : 100)
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}


struct ToastModifier: ViewModifier {
    let text: String
    @Binding var showToast: Bool
    
    func body(content: Content) -> some View {
        ZStack{
            /// `content`: an image, some complex view.
            /// The background view on top with `ZStack`
            content
            
            TextWithBackgroundView(text: text)
                .offset(y: showToast ? 0 : 100)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

extension View {
    func toast(text: String, showToast: Binding<Bool>) -> some View {
        self.modifier(ToastModifier(text: text, showToast: showToast))
    }
}


#Preview {
    ToastView(text: "Hello Toast", showToast: .constant(true))
}
