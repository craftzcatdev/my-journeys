//
//  ContentView.swift
//  DIQRScanner
//
//  Created by Hai Ng. on 21/3/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScanner: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Button {
                    showScanner.toggle()
                } label: {
                    Text("Show Scanner")
                }

            }
            .navigationTitle("QR Scanner")
            .qrScanner(isScanning: $showScanner) { code in
                print("The scanned code is: \(code)")
            }
        }
    }
}

#Preview {
    ContentView()
}
