    //
    //  ContentView.swift
    //  Hiya
    //
    //  Created by Hai Ng. on 12/3/26.
    //

    import SwiftUI
    import FoundationModels // That provide LLM on device

    struct ContentView: View {
        private var llm = SystemLanguageModel.default
        private var session = LanguageModelSession()
        
        @State private var response: String = ""
        @State private var isLoading: Bool = false
        
        var body: some View {
            VStack {
                Spacer()
                
                switch llm.availability {
                case .available:
                    if response.isEmpty {
                        if isLoading {
                            ProgressView()
                        } else {
                            Text("Tab the button to get a fun response.")
                                .foregroundStyle(.tertiary)
                                .multilineTextAlignment(.center)
                                .font(.title)
                        }
                    }else {
                        Text(response)
                            .multilineTextAlignment(.center)
                            .font(.largeTitle)
                            .bold()
                    }
                case .unavailable(.deviceNotEligible):
                    Text("I'm sorry, but I can't help you with that.")
                case .unavailable(.appleIntelligenceNotEnabled):
                    Text("Please enable Apple Intelligence in Settings.")
                case .unavailable(.modelNotReady):
                    Text("The AI models is not ready yet. Try again later")
                case .unavailable(_):
                    Text("The AI feature is not avaiable for an unknown reason.")
                }
                
                Spacer()
                
                Button {
                    Task {
                        isLoading = true
                        defer { isLoading = false }
                        
                        let prompt = "Say hi in a fun way."
                        
                        do {
                            let replay = try await session.respond(to: prompt)
                            response = replay.content
                        } catch {
                            response = "Something went wrong: \(error.localizedDescription)"
                        }
                    }
                } label: {
                    Text("Welcome!")
                        .font(.largeTitle)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .buttonSizing(.flexible)
                .glassEffect(.regular.interactive())
            }
            .padding()
            .tint(.teal)
        }
    }

    #Preview {
        ContentView()
    }
