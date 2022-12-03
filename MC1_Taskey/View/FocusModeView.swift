//
//  FocusModeView.swift
//  MC1_Polar
//
//  Created by Ciro Forchetta on 24/10/22.
//

import SwiftUI
import Combine

struct FocusModeView: View {
    
    @ObservedObject private var FocusModeViewModel: FocusModeVM = FocusModeVM(focusTime: 45*60+1, restTime: 900.9)
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var goalVM: GoalViewModel
    @Binding var currentGoal: Goal
    
//    @State private var currentTask: Task?
    
//        self.currentTask = findCurrentTask(currentGoal: currentGoal)
    
    var body: some View {
        ZStack{
            switch FocusModeViewModel.screenState {
            case .focused:
                Color("FocusedBackgroundColor").ignoresSafeArea()
                VStack (alignment: .leading) {
                    FocusTaskView(currentGoal: currentGoal)
                    Spacer()
                    FocusTimerView(timeToSwitch: FocusModeViewModel.timeRemaining)
                    Spacer()
                    HStack(spacing: 30) {
                        
                        RoundButton(
                            buttonColor: "FocusedButtonColor",
                            buttonSymbol: "pause.fill",
                            onTap: {
                                FocusModeViewModel.screenState = .paused
                                FocusModeViewModel.pauseQueue()
                            }
                        )
                        TextRectangleButton(
                            buttonColor: "FocusedButtonColor",
                            buttonText: "COMPLETE",
                            onTap: {
//                                Find next incomplete task, complete if there is more than one incomplete task – complete it, if there is only one left – complete it and dismiss FocusModeView
                                if let currentTaskIndex = findCurrentTaskIndex(currentGoal: currentGoal) {
                                    if currentGoal.taskList.filter({ $0.doneStatus == false }).count > 1 {
                                        currentGoal.taskList[currentTaskIndex].doneStatus = true
                                        print(currentGoal.taskList.filter({ $0.doneStatus == true }))
                                    } else {
                                        currentGoal.taskList[currentTaskIndex].doneStatus = true
                                        dismiss()
                                        print(currentGoal.taskList.filter({ $0.doneStatus == true }))
                                    }
                                }
                            }
                        )
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                                
            case .paused:
                Color("PausedBackgroundColor").ignoresSafeArea()
                VStack (alignment: .leading) {
                    FocusTaskView(currentGoal: currentGoal)
                    Spacer()
                    FocusTimerView(timeToSwitch: FocusModeViewModel.timeRemaining)
                    Spacer()
                    HStack(spacing: 30) {
                        RoundButton(
                            buttonColor: "FocusedButtonColor",
                            buttonSymbol: "play.fill",
                            onTap: {
                                FocusModeViewModel.resumeQueue()
                                FocusModeViewModel.screenState = .focused
                            }
                        )
                        TextRectangleButton(
                            buttonColor: "PausedButtonColor",
                            buttonText: "STOP",
                            onTap: {
                                print("Work Stopped")
                                dismiss()
                            }
                        )
                    }
                }
                .padding()
                        
            case .resting:
                Color("RestingBackgroundColor").ignoresSafeArea()
                VStack (alignment: .leading) {
                    FocusTaskView(currentGoal: currentGoal)
                    Spacer()
                    FocusTimerView(timeToSwitch: FocusModeViewModel.timeRemaining)
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
                                FocusModeViewModel.screenState = .focused
                                FocusModeViewModel.timeRemaining = FocusModeViewModel.focusTime
                            })
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
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

//    The current task is the first one in the array which is not done.
func findCurrentTaskIndex(currentGoal: Goal) -> Int? {
    //print(currentGoal.taskList.firstIndex { $0.doneStatus == false } ?? nil)
    return currentGoal.taskList.firstIndex { $0.doneStatus == false } ?? nil
}
    
    // MARK: - Preview
    
/*struct focusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusModeView(currentGoal: .constant (goalData[0]))
    }
}*/
