//
//  ContentView.swift
//  DIQRScanner
//
//  Created by Hai Ng. on 21/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showScanner: Bool = false
    @State private var scannedCodes: [String] = []
    @State private var lastScannedCode: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                List(scannedCodes, id: \.self) { code in
                    Text(code)
                        .font(.caption.monospaced())
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showScanner = true
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                            .symbolEffect(.bounce)
                    }

                }
            }
            .navigationTitle("QR Scanner")
            .qrScanner(isScanning: $showScanner) { code in
                lastScannedCode = code
                scannedCodes.insert(code, at: 0)
            }
        }
    }
}

#Preview {
    ContentView()
}
