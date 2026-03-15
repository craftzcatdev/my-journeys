//
//  CustomButtonView.swift
//  Hike
//
//  Created by Hai Ng. on 15/3/26.
//

import SwiftUI

struct CustomButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.customGreenLight, .customGreenMedium],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [.customGrayLight, .customGrayMedium],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 4
                )
            
            Image(systemName: "figure.hiking")
                .font(.system(size: 30).weight(.black))
                .foregroundStyle(LinearGradient(colors: [.customGrayLight, .customGrayMedium], startPoint: .top, endPoint: .bottom))
        }
        .frame(width: 58, height: 58)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CustomButtonView()
        .padding()
}
