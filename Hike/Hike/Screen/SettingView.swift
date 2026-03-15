//
//  SettingView.swift
//  Hike
//
//  Created by Hai Ng. on 15/3/26.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List {
            //MARK: - SECTION: HEADER
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "laurel.leading")
                        .font(.system(size: 88).weight(.black))
                    VStack(spacing: -10) {
                        Text("Hike")
                            .font(.system(size: 66).weight(.black))
                        Text("Editor' Choise")
                            .fontWeight(.medium)
                    }
                    Image(systemName: "laurel.trailing")
                        .font(.system(size: 88).weight(.black))
                    Spacer()
                }//HSTACK
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            .customGreenLight,
                            .customGreenMedium,
                            .customGreenDark
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .padding(.top, 8)
                
                VStack (spacing: 8) {
                    Text("Where can you find \nperfect tracks?")
                        .font(.title2.weight(.heavy))
                    
                    Text(
                        "The hike which looks gorgrous in photos but is even better once you are actually there. The hike that you hope to do again someday. \nFind the best dat hikes in the app."
                    )
                    .font(.footnote)
                    .italic()
                    Text("Dust off the boots! It's tome for a walk.")
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.customGreenMedium)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
            }//: HEADER
            .listRowSeparator(.hidden)
            //MARK: - SECTION: ICON
            
            //MARK: - SECTION: ABOUT
        }//LIST
    }
}

#Preview {
    SettingView()
}
