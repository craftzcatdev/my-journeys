    //
    //  ContentView.swift
    //  Room
    //
    //  Created by Hai Ng. on 19/3/26.
    //

import SwiftUI
import SwiftData

struct ColorSelector: View {
    @Binding var selection: Color
    let colors: [Color] = [
        .red,
        .yellow,
        .orange,
        .gray,
        .purple,
        .pink,
        .green
    ]
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .fill(color)
                    .overlay {
                        selection == color ? Circle()
                            .stroke( Color.primary, lineWidth: 2) : nil
                    }
                    .onTapGesture {
                        selection = color
                    }
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @State private var name: String = ""
    @State private var color: Color = .red
    
    @Query private var rooms: [Room] = []
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .font(.title.weight(.medium))
                .textFieldStyle(.roundedBorder)
            
            ColorSelector(selection: $color)
            
            Button {
                let uiColor = UIColor(color).resolvedColor(
                    with: UITraitCollection.current
                )
                let room = Room(name: name, color: uiColor)
                
                context.insert(room)
                name = ""
            } label: {
                Text("Save")
                    .font(.title3.weight(.medium))
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 20)
            .buttonStyle(.glassProminent)
            
            List(rooms) { room in
                HStack {
                    Text(room.name)
                    Spacer()
                    Rectangle()
                        .fill(Color(uiColor: room.color))
                        .frame(width: 50, height: 50)
                        .clipShape(.rect(cornerRadius: 16))
                }
            }

            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Room.self], inMemory: true)
}
