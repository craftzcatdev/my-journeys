//
//  SettingView.swift
//  Hike
//
//  Created by Hai Ng. on 15/3/26.
//

import SwiftUI

struct SettingView: View {
    //MARK: - PROPERTIES
    
    private let alternateAppIcons: [String] = [
        "AppIcon-Backpack",
        "AppIcon-Camera",
        "AppIcon-Campfire",
        "AppIcon-MagnifyingGlass",
        "AppIcon-Map",
        "AppIcon-Mushroom"
    ]
    
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
            // ISSUE: iOS Simulator not support? Issue date: 15 Mar 2026 - iPhone 17 Pro - 26.3.1
            // Phycical device => OK (using iPhone 15 Pro - 26.3.1)
            Section(header: Text("Alternate Icons")) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(alternateAppIcons.indices, id: \.self) { item in
                            Button {
                                print(
                                    "Icon \(alternateAppIcons[item]) was pressed."
                                )
                            
                                UIApplication.shared
                                    .setAlternateIconName(
                                        alternateAppIcons[item]
                                    ) { error in
                                        if error != nil {
                                            print(
                                                "Failed request to update the app's icon: \(String(describing: error?.localizedDescription))"
                                            )
                                        } else {
                                            print(
                                                "Success! You have changed the app's icon to \(alternateAppIcons[item])"
                                            )
                                        }
                                    }
                            } label: {
                                Image("\(alternateAppIcons[item])-Preview")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(.rect(cornerRadius: 16))
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                } //: SCROLL VIEW
                .padding(.top, 12)
                    
                Text(
                    "Choose your favourite app icon from the collection above."
                )
                .frame(minWidth: 0, maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .font(.footnote)
                .padding(.bottom, 12)
            } //: SECTION
            .listRowSeparator(.hidden)
            
            //MARK: - SECTION: ABOUT
            Section(
                header: Text("ABOUT THE APP"),
                footer: HStack {
                    Spacer()
                    Text("Copyright © \(Date.now, format: .dateTime.year()), All rights reserved.")
                    Spacer()
                }
                    .padding(.vertical, 8)
            ){
                // 1. Basic Labeled Content
                // LabeledContent("Application Name",value: "DatHike")
                
                // 2. Advanced Labeled Content
                CustomListRowView(
                    rowLabel: "Application",
                    rowIcon: "apps.iphone",
                    rowContent: "HIKE",
                    rowTintColor: .blue
                )
                        
                CustomListRowView(
                    rowLabel: "Compatibility",
                    rowIcon: "info.circle",
                    rowContent: "iOS, iPadOS",
                    rowTintColor: .red
                )
                        
                CustomListRowView(
                    rowLabel: "Technology",
                    rowIcon: "swift",
                    rowContent: "Swift",
                    rowTintColor: .orange
                )
                        
                CustomListRowView(
                    rowLabel: "Version",
                    rowIcon: "gear",
                    rowContent: "1.0",
                    rowTintColor: .purple
                )
                        
                CustomListRowView(
                    rowLabel: "Developer",
                    rowIcon: "ellipsis.curlybraces",
                    rowContent: "John Doe",
                    rowTintColor: .mint
                )
                        
                CustomListRowView(
                    rowLabel: "Designer",
                    rowIcon: "paintpalette",
                    rowContent: "Robert Petras",
                    rowTintColor: .pink
                )
                        
                CustomListRowView(
                    rowLabel: "Website",
                    rowIcon: "globe",
                    rowTintColor: .indigo,
                    rowLinkLabel: "Credo Acedemy",
                    rowLinkDestination: "https://credo.academy"
                )
            }//: SECTION
        }//LIST
    }
}

#Preview {
    SettingView()
}
