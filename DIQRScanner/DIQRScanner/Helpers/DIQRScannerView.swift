//
//  DIQRScannerView.swift
//  DIQRScanner
//
//  Created by Hai Ng. on 21/3/26.
//

import SwiftUI
import AVFoundation

fileprivate struct CameraProperties {
    var session: AVCaptureSession = .init()
    var output: AVCaptureMetadataOutput = .init()
    var scannedCode: String?
    var permissionState: Permission?
    
    enum Permission: String {
        case idle = "Not Determined"
        case approved = "Access Granted"
        case denied = "Access Denied"
    }
    
    static func checkAndAskCameraPermission() async -> Permission? {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: return Permission.approved
            case .notDetermined:
                /// Requesting camera access
                if await AVCaptureDevice.requestAccess(for: .video) {
                    /// Permission Granted
                    return Permission.approved
                } else {
                    return Permission.denied
                }
            case .denied, .restricted: return Permission.denied
            default: return nil
        }
    }
}

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
    @State private var camera: CameraProperties = .init()
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            /// Dynamic Island
            let haveDynamicIsland: Bool = safeArea.top >= 59
            let dynamicIslandwidth: CGFloat = 120
            let dynamicIslandHeight: CGFloat = 36
            let topOffset: CGFloat = haveDynamicIsland ?  (11 + max((safeArea.top - 59), 0)) : (
                isExpanding ? (
                    nonDynamicIslandHaveSpacing ? safeArea.top : -20
                ): -50
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
                        .offset(
                            y: nonDynamicIslandHaveSpacing || haveDynamicIsland ? 0 : 10
                        )
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
                camera.permissionState = await CameraProperties
                    .checkAndAskCameraPermission()
            }
            .onChange(of: camera.scannedCode) { oldValue, newValue in
                if let newValue {
                    onScan(newValue)
                    toggle(false)
                }
            }
        }
        .statusBarHidden()
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
            if let permissionState = camera.permissionState {
                if permissionState == .approved {
                    CameraLayerView(size: size, camera: $camera)
                        .overlay(alignment: .top) {
                            scannerAnimation(size.height)
                        }
                }
                
                if permissionState == .denied {
                    /// Show info with setting url to change the camera settings!
                    VStack(spacing: 4) {
                        Image(systemName: "camera.viewfinder")
                            .font(.system(size: size.width * 0.15))
                            .foregroundStyle(.white)
                        
                        Text("Permission Denied")
                            .font(.caption)
                            .foregroundStyle(.red)
                        
                        if let settingUrl = URL(
                            string: UIApplication.openSettingsURLString
                        ) {
                            Button("Go to settings") {
                                openURL(settingUrl)
                            }
                            .font(.caption)
                            .foregroundStyle(.white)
                            .underline()
                        }
                    }
                    .fixedSize()
                }
            }
            
            
            shape
                .stroke(.white, lineWidth: 2)
        }
        .frame(width: size.width, height: size.height)
        .clipShape(shape)
    }
    
    /// Scanner Animation
    @ViewBuilder
    private func scannerAnimation(_ height: CGFloat) -> some View {
        Rectangle()
            .fill(Color.white)
            .frame(height: 2.5)
            .phaseAnimator(
                [false, true],
                content: {
                    content,
                    isCanning in
                    content
                        .shadow(
                            color: .black.opacity(0.8),
                            radius: 8,
                            x: 0,
                            y: isCanning ? 15 : -15
                        )
                        .offset(y: isCanning ? height : 0)
                },
                animation: { _ in
                        .easeInOut(duration: 0.85).delay(0.1)
                })
    }
    
    private func toggle (_ status: Bool) {
        withAnimation(
            .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
        ) {
            isExpanding = status
        } completion: {
            if !status {
                /// Stoping Session (Saftey way)
                DispatchQueue.global().async {
                    camera.session.stopRunning()
                }
                showContent = false
            }
        }
    }
    
    var nonDynamicIslandHaveSpacing: Bool {
        return false
    }
}

fileprivate struct CameraLayerView: UIViewRepresentable {
    
    var size: CGSize
    @Binding var camera: CameraProperties
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    
    func makeUIView(context: Context) ->  UIView {
        
        let view = UIView(frame: .init(origin: .zero, size: size))
        view.backgroundColor = .clear
        
        /// Setting up camera player
        let layer = AVCaptureVideoPreviewLayer(session: camera.session)
        layer.frame = .init(origin: .zero, size: size)
        layer.videoGravity = .resizeAspectFill
        layer.masksToBounds = true
        view.layer.addSublayer(layer)
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    

    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: CameraLayerView
        init(parent: CameraLayerView) {
            self.parent = parent
            super.init()
            setupCamera()
        }
        
        func setupCamera() {
            
            do {
                let session = parent.camera.session
                let output = parent.camera.output
                
                guard !session.isRunning else { return }
                ///Finding Back Camera
                guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                    return
                }
                
                /// Camera input
                let input = try AVCaptureDeviceInput(device: device)
                /// For Extra Saftey
                /// Checking Whether input & output can be add to the session
                guard session
                    .canAddInput(input), session
                    .canAddOutput(output) else { return }
                
                /// Add input and output to Camera Session
                session.beginConfiguration()
                session.addInput(input)
                session.addOutput(output)
                /// Setting Out put config to read QR Code From Camera
                output.metadataObjectTypes = [.qr]
                ///Adding Delegate to Retrived the Fetched QR Code From Camera
                output.setMetadataObjectsDelegate(self, queue: .main)
                session.commitConfiguration()
                /// Starting Session
                /// NOTE: Sesstion must be started in background thread
                DispatchQueue.global(qos: .background).async {
                    session.startRunning()
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        func metadataOutput(
            _ output: AVCaptureMetadataOutput,
            didOutput metadataObjects: [AVMetadataObject],
            from connection: AVCaptureConnection
        ) {
            /// FETCH QR CODE
            if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject, let code = object.stringValue {
                /// One Time update
                guard parent.camera.scannedCode == nil else { return }
                parent.camera.scannedCode = code
                
            }
        }
    }
    
}

#Preview {
    ContentView()
}
