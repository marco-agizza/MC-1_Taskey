//
//  FocusModeView.swift
//  MC1_Polar
//
//  Created by Ciro Forchetta on 24/10/22.
//

import SwiftUI
import Combine

struct FocusModeView: View {
    
    @ObservedObject private var vm: FocusModeVM = FocusModeVM(focusTime: 45*60+1, restTime: 900.9)
    // Buttons
    
    
    var body: some View {
        ZStack{
            switch vm.screenState {
            case .focused:
                Color("FocusedBackgroundColor").ignoresSafeArea()
                VStack {
                    Spacer()
                    FocusTimerView(timeToSwitch: vm.timeRemaining)
                    Spacer()
                    HStack(spacing: 30) {
                        
                        RoundButton(
                            buttonColor: "FocusedButtonColor",
                            buttonSymbol: "pause.fill",
                            onTap: {
                                vm.screenState = .paused
                                vm.pauseQueue()
                            }
                        )
                        TextRectangleButton(
                            buttonColor: "FocusedButtonColor",
                            buttonText: "COMPLETE",
                            onTap: { print("task Completed") }
                        )
                    }
                }
                                
            case .paused:
                Color("PausedBackgroundColor").ignoresSafeArea()
                VStack {
                    Spacer()
                    FocusTimerView(timeToSwitch: vm.timeRemaining)
                    Spacer()
                    HStack(spacing: 30) {
                        RoundButton(
                            buttonColor: "FocusedButtonColor",
                            buttonSymbol: "play.fill",
                            onTap: {
                                vm.resumeQueue()
                                vm.screenState = .focused
                            }
                        )
                        TextRectangleButton(
                            buttonColor: "PausedButtonColor",
                            buttonText: "STOP",
                            onTap: { print("Work Stopped") }
                        )
                    }
                }
                        
            case .resting:
                Color("RestingBackgroundColor").ignoresSafeArea()
                VStack {
                    Spacer()
                    FocusTimerView(timeToSwitch: vm.timeRemaining)
                    Spacer()
                    HStack(spacing: 30) {
                        RoundButton(
                            buttonColor: "RestingButtonColor",
                            buttonSymbol: "stop.fill",
                            onTap: {}
                        )
                        TextRectangleButton(
                            buttonColor: "RestingButtonColor",
                            buttonText: "CONTINUE",
                            onTap: {
                                vm.screenState = .focused
                                vm.timeRemaining = vm.focusTime
                            })
                    }
                }
            }
        }
    }
}

// MARK: - Handlers and formatting helpers

private extension FocusModeView {
    class FocusModeVM: ObservableObject {
        
        @Published var timeRemaining: TimeInterval
        @Published var screenState: FocusState
        
        let focusTime: TimeInterval
        let restTime: TimeInterval
        // Dependencies
        private let queue = DispatchQueue(label: "com.Polar.FocusScreenScheduler", qos: .userInitiated)
        private var bag = Set<AnyCancellable>()
        
        // Focus state enum
        enum FocusState {
            case focused
            case paused
            case resting
        }
        
        //
        
        init(focusTime: TimeInterval, restTime: TimeInterval) {
            
            self.focusTime = focusTime
            self.restTime = restTime
            self.timeRemaining = focusTime
            self.screenState = .focused
            
            setupQueue()
        }
        
        private func setupQueue() {
            let interval: TimeInterval = 0.1
//            let action: () -> Void
            let cancellable = queue.schedule(after: .init(.now()), interval: .seconds(interval)) { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if self.timeRemaining >= 0 {
                        self.timeRemaining -= interval
                    } else {
                        switch self.screenState {
                        case .focused:
                            self.screenState = .resting
                            self.timeRemaining = self.restTime
                        case .resting:
                            self.screenState = .focused
                            self.timeRemaining = self.focusTime
                        case .paused:
                            assertionFailure("This state was not supposed to happen")
                        }
                    }
                }
            }
            cancellable.store(in: &bag)
        }
        
        func pauseQueue() {
            queue.suspend()
        }
        
        func resumeQueue() {
            queue.resume()
        }
        
        
        
    }
}

private extension FocusModeView {
    struct RoundButtonStyle: ButtonStyle {
        
//        var roundButtonSymbols = [pause.fill, play.fill, stop.fill]
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
//                .symbolVariant(<#T##variant: SymbolVariants##SymbolVariants#>)
                .font(.title.bold())
            
        }
    }
    
    struct TextButtonStyle {
        
    }
}
    
    // MARK: - Preview
    
struct focusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusModeView()
    }
}
