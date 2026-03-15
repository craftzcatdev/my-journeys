//
//  CardView.swift
//  Hike
//
//  Created by Hai Ng. on 15/3/26.
//

import SwiftUI

struct CardView: View {
    
    @State private var imageNumber: Int = 1
    @State private var randomNumber: Int = 1
    @State private var isShowingSheet: Bool = false
    
    func randomImage() {
        print("---BUTTON WAS PRESSED ---")
        print("Status: Old Image Number = \(imageNumber)")
        
        repeat {
            randomNumber = Int.random(in: 1...5)
            print("Action: Random Number Generate = \(randomNumber)")
        } while randomNumber == imageNumber
        
       
        imageNumber = randomNumber
        print("Result: New Image Number = \(imageNumber)")
        print("--- The End ---")
        print("\n")
    }
    
    var body: some View {
        //MARK: - CARD
        
        
        ZStack {
            CustomBackgroundView()
            
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Hiking")
                            .fontWeight(.black)
                            .font(.system(size: 52))
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [
                                            .customGrayLight,
                                            .customGrayMedium
                                        ]
                                    ),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        Spacer()
                        
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            CustomButtonView()
                        }
                        .sheet(isPresented: $isShowingSheet) {
                            SettingView()
                                .presentationDragIndicator(.visible)
                                .presentationDetents([.medium, .large])
                        }


                    }
                    
                    Text(
                        "Fun and enjoyable outdoor activity for friends and families."
                    )
                    .multilineTextAlignment(.leading)
                    .italic()
                    .foregroundStyle(Color.customGrayMedium)
                }
                .padding(.horizontal, 30)
                
                ZStack {
                    CustomCircleView()
                    
                    Image("image-\(imageNumber)")
                        .resizable()
                        .scaledToFit()
                        .animation(.default, value: imageNumber)
                }
                
                Button {
                    randomImage()
                } label: {
                    Text("Explore More")
                        .font(.title2.weight(.heavy))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.customGreenLight, .customGreenMedium],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(
                            color: .black
                                .opacity(0.25), radius: 0.25, x: 1, y: 2
                        )
                }
                .buttonStyle(GradientButton())
                

            }
        } //: CARD
        .frame(width: 320, height: 570)
    }
}

#Preview {
    CardView()
}
