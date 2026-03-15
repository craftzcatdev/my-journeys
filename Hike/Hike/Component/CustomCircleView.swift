//
//  CustomCircleView.swift
//  Hike
//
//  Created by Hai Ng. on 15/3/26.
//

import SwiftUI

struct CustomCircleView: View {
    @State private var isAnimateGradient: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            .customIndigoMedium,
                            .customGrayLight
                        ],
                        startPoint: isAnimateGradient ? .topTrailing : .bottomLeading,
                        endPoint: isAnimateGradient ? .bottomTrailing : .topTrailing
                    )
                )
                .onAppear {
                    withAnimation(
                        .linear(duration: 3.0).repeatForever(autoreverses: true)
                    ) {
                        isAnimateGradient.toggle()
                    }
                }
            MotionAnimationView()
        }// ZSTACK
        .frame(width: 256, height: 256)
    }
}

#Preview {
    CustomCircleView()
}
