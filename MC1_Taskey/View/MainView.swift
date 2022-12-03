//
//  MainView.swift
//  MC1_Taskey
//  Polar
//
//  Created by Marco Agizza on 19/10/22.
//

import SwiftUI

struct MainView: View {
    @State private var selection: String? = nil
    @State private var showingGoalCreationSheet = false
    @State private var showingGoalDetailsSheet : Bool = false
    
    @StateObject var goalVM = GoalViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<goalVM.goals.count, id: \.self) { index in
                    GoalCardView(currGoal: goalVM.goals[index])
                        .onTapGesture {
                            goalVM.selectedGoal = index
                            showingGoalDetailsSheet.toggle()
                        }
                }
                .onDelete(perform: goalVM.remove)
                .onMove(perform: move)
            }
            .listStyle(.plain)
            .sheet(isPresented: $showingGoalDetailsSheet) {
                GoalDetailsView(goalVM: goalVM, goal: goalVM.goals[goalVM.selectedGoal])
            }
            .navigationBarTitle("Your goals")
            .navigationBarItems(
                trailing:
                    Button {
                        print("add a new goal pressed")
                        showingGoalCreationSheet.toggle()
                    } label: {
                        Label("Add goal", systemImage: "plus.app.fill")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.blue)
                    .sheet(isPresented: $showingGoalCreationSheet, content: {
                        GoalCreationView(goalTitle: "", goalDescription: "", currTaskTitle: "", goalVM: goalVM)
                    }
                          )
            )
        }
    }
    
    
    // TODO Current implementation violates single responsibility principle
    func move(from source: IndexSet, to destination: Int) {
        goalVM.goals.move(fromOffsets: source, toOffset: destination )
        goalVM.goals[0].isPrimary = true
        for index in goalVM.goals[1...].indices {
            goalVM.goals[index].lowerPriority()
        }
    }
    //
    //    func resetPriority() {
    //            goalVM.goals[0].isPrimary = true
    //            for index in goalVM.goals[1...].indices {
    //                goalVM.goals[index].lowerPriority()
    //            }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
