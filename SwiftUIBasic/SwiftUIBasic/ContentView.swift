//
//  ContentView.swift
//  SwiftUIBasic
//
//  Created by Hai Ng. on 22/3/26.
//

import SwiftUI

@Observable
class Counter {
    var count = 0
    var countSecond = 0
    var countThird = -1
}

struct ContentView: View {
    @State var counter = Counter()

    var body: some View {
        VStack {
            Text("Count: \(counter.count) \(counter.countSecond) \(counter.countThird)")
            HStack {
                Button("+") { counter.count += 1 }
                Button("+") { counter.countSecond += 1 }
                Button("+") { counter.countThird += 1 }
            }
            ChildView(counter: counter)
        }
        .font(.largeTitle)
        .environment(counter)
    }
}

struct ChildView: View {
    var counter: Counter

    var body: some View {
        VStack {
            Text("Child Count: \(counter.count) \(counter.countSecond) \(counter.countThird)")
            HStack {
                Button("+") { counter.count += 1 }
                Button("+") { counter.countSecond += 1 }
                Button("+") { counter.countThird += 1 }
            }
            GrandChildView()
        }.font(.largeTitle)
    }
}

struct GrandChildView: View {
    @Environment(Counter.self) var counter

    var body: some View {
        VStack {
            Text("GrandChild Count: \(counter.count) \(counter.countSecond) \(counter.countThird)")
            HStack {
                Button("+") { counter.count += 1 }
                Button("+") { counter.countSecond += 1 }
                Button("+") { counter.countThird += 1 }
            }
        }.font(.largeTitle)
    }
}

#Preview {
    ContentView()
}
