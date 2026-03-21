//
//  DIQRScannerView.swift
//  DIQRScanner
//
//  Created by Hai Ng. on 21/3/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func qrScanner(isScanning: Binding<Bool>, onScan: @escaping (String) -> Void) -> some View {
        self.modifier(
            QRScannerViewModified(isScanning: isScanning, onScan: onScan)
        )
    }
}

fileprivate struct QRScannerViewModified: ViewModifier {
    
    @Binding var isScanning: Bool
    var onScan: (String) -> Void
    
    /// Modifier Properties
    @State private var showFullScreenCover: Bool = false
    func body(content: Content)-> some View {
        content
            .fullScreenCover(isPresented: $showFullScreenCover) {
                DIQRScannerView {
                    isScanning = false
                    Task { @MainActor in
                        showFullScreenConvertWithAnimation(false)
                    }
                } onScan: { code in
                    onScan(code)
                }
                .presentationBackground(.clear)

            }
            .onChange(of: isScanning) { oldValue, newValue in
                if newValue {
                    showFullScreenConvertWithAnimation(true)
                }
            }
    }
    
    private func showFullScreenConvertWithAnimation(_ status: Bool) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            showFullScreenCover = status
        }
    }
}

fileprivate struct DIQRScannerView: View {
    
    var onClose: () -> Void
    var onScan: (String) -> Void
    
    /// View Properties
    @State private var isInitialized: Bool = false
    @State private var showContent: Bool = false
    @State private var isExpanding: Bool = false
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            /// Dynamic Island
            let haveDynamicIsland: Bool = safeArea.top >= 59
            let dynamicIslandwidth: CGFloat = 120
            let dynamicIslandHeight: CGFloat = 36
            let topOffset: CGFloat = haveDynamicIsland ?  (11 + max((safeArea.top - 59), 0)) : (
                isExpanding ? (nonDynamicIslandHaveSpacing ? safeArea.top : -20): -50
            )
            
            let expandedwidth: CGFloat = size.width - 30
            /// For making is square
            let expandedHeight: CGFloat = expandedwidth
            
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .contentShape(.rect)
                    .opacity(isExpanding ? 1 : 0)
                    .onTapGesture {
                        toggle(false)
                    }
                
                /// Scanner Animated View
                if showContent {
                    ConcentricRectangle(
                        corners: .concentric(minimum: .fixed(30)),
                        isUniform: true
                    )
                    .fill(.black)
                    .overlay {
                        GeometryReader {
                            let cameraSize = $0.size
                            
                            ScannerView(cameraSize)
                        }
                        .overlay(alignment: .bottom) {
                            //MARK: - Your Custom Text
                            Text("Scan the QR Code")
                                .font(.caption2)
                                .foregroundStyle(.white.secondary)
                                .lineLimit(1)
                                .fixedSize()
                                .offset(y: 25)
                        }
                        .padding(80)
                        .compositingGroup()
                        .blur(radius: isExpanding ? 0 : 20)
                        .opacity(isExpanding ? 1 : 0)
                        .geometryGroup()
                        .offset(y: nonDynamicIslandHaveSpacing || haveDynamicIsland ? 0 : 10)
                    }
                    .frame (
                        width: isExpanding ? expandedwidth : dynamicIslandwidth, height: isExpanding ? expandedHeight: dynamicIslandHeight
                    )
                    .offset(y: topOffset)
                    .background {
                        if isExpanding {
                            Rectangle()
                                .fill(.clear)
                                .onAppear {
                                    showContent = true
                                }
                        }
                    }
                    .transition(.identity)
                    .onDisappear {
                        onClose()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
            .task {
                guard !isInitialized else { return }
                isInitialized = true
                showContent = true
                try? await Task.sleep(for: .seconds(0.05))
                toggle(true)
            }
        }
    }
    
    /// Scanner view
    @ViewBuilder
    fileprivate func ScannerView(_ size: CGSize) -> some View {
        let shape = RoundedRectangle(
            cornerRadius: size.width * 0.05,
            style: .continuous
        )
        ZStack {
            /// Camera AVSessionLayer View!
            
            
            
            shape
                .stroke(.white, lineWidth: 2)
        }
        .frame(width: size.width, height: size.height)
        .clipShape(shape)
    }
    
    private func toggle (_ status: Bool) {
        withAnimation(
            .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
        ) {
            isExpanding = status
        } completion: {
            if !status {
                showContent = false
            }
        }
    }
    
    var nonDynamicIslandHaveSpacing: Bool {
        return false
    }
}

#Preview {
    ContentView()
}
