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
    @State private var showingGoalDetailsSheet : Goal? = nil
    
    @ObservedObject var goalVM = GoalViewModel()
    
//    func move(from source: IndexSet, to destination: Int) {
//        tasks.move(fromOffsets: source, toOffset: destination )
//    }
    
    var body: some View {
        NavigationView {
                List {
                    ForEach(goalVM.goals) { currGoal in
                        GoalCardView(currGoal: currGoal)
                            .onTapGesture {
                                self.showingGoalDetailsSheet = currGoal
                            }
                            /*.background(
                                NavigationLink(
                                    destination: GoalDetailsView(goal: currGoal),
                                    label:{}
                                )
                                .opacity(0.0)
                                .buttonStyle(PlainButtonStyle())
                            )*/
                        //                            .onDrag({
                        //                                self.draggedItem = currGoal
                        //                                return NSItemProvider(item: nil, typeIdentifier: currGoal)
                        //                            })
                    }
                    .onDelete(perform: goalVM.remove)
                    .onMove(perform: move)
                }
                .listStyle(.plain)
                .sheet(item: self.$showingGoalDetailsSheet) { goal in
                    GoalDetailsView(goal: goal)
                }
//                .padding(0.0)
//                .background(.opacity(0.0))
//                .animation(.easeInOut, value: currGoal)
//            .scrollContentBackground(.hidden)
            
            .navigationBarTitle("Your goals")
            .navigationBarItems(
                trailing:
                    Button {
                    print("add a new goal pressed")
                    showingGoalCreationSheet.toggle()
                } label: {
                    Label("Add goal", systemImage: "plus.app.fill").font(.system(size: 22))
                }
                .foregroundColor(.blue)
                .sheet(isPresented: $showingGoalCreationSheet, content: {
                        GoalCreationView(goalTitle: "", goalDescription: "", currTaskTitle: "", goalVM: goalVM)
                    }
                )
                
                /*NavigationLink(
                    destination: GoalCreationView(goal_title: "", description: ""),
                    label: {Text("Add")}
                )*/
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
