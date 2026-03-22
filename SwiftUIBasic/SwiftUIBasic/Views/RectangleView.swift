//
//  RectangleView.swift
//  SwiftUIBasic
//
//  Created by Hai Ng. on 22/3/26.
//

import SwiftUI

struct RectangleView: View {
    var body: some View {
        
        Rectangle()
        /// View modifier
            .fill(.red)
        /// Có thể sử dụng `.infinity` hoặc `CGFloat.infinity`
            .frame(width: .infinity, height: CGFloat.infinity)
        /// Ignore SafeArea để hiển thị `Rectangle` lên `Status Bar` và `Bottom Bar`
            .ignoresSafeArea(edges: .all)
        /// `.overlay` => Overlayout
            .overlay {
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20), style: .circular)
                    .fill(.green)
                    .frame(width: 350, height: 350)
                    .shadow(color: .white, radius: 10, x: 10, y: 10)
                    .overlay {
                        Circle()
                            .fill(.blue)
                            .border(.black, width: 5)
                            .frame(width: 200, height: 200)
                            .overlay {
                                Path { path in
                                    path.move(to: CGPoint(x: 20, y: 20))
                                    path.addLine(to: CGPoint(x: 180, y: 20))
                                }
                                .stroke(Color.yellow, lineWidth: 5)
                            }
                    }
                
            }
    }
}

#Preview {
    RectangleView()
}
