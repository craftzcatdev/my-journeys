//
//  ZStackView.swift
//  SwiftUIBasic
//
//  Created by Hai Ng. on 24/3/26.
//

import SwiftUI

struct ZStackView: View {
    /// let scale = UIScreen.main.scale
    /// In iOS 26, `UIScreen.main` is fully `deprecated` because it doesn't work correctly with multi-window/multi-scene iPadOS apps.
    /// The proper `SwiftUI` replacement for .scale is the `@Environment(\.displayScale)` property wrapper, which reads the display scale directly from the current view's trait collection.
    @Environment(\.displayScale) var scale
    let withPx: CGFloat = 300
    var withPt: CGFloat { withPx / scale }

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.yellow)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            Rectangle()
                .fill(.blue)
                .overlay { Rectangle().stroke(.green, lineWidth: 10) }
                .overlay { Rectangle().strokeBorder(.pink, lineWidth: 10) }
                .frame(width: 300, height: 300)
            Rectangle()
                .fill(Color.red.opacity(0.5))
                .frame(width: 400, height: withPt)
        }
    }
}

#Preview {
    ZStackView()
}

