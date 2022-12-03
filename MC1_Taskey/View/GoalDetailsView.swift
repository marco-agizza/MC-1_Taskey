//
//  GoalDetailsView.swift
//  MC1_Taskey
//  Polar
//
//  Created by Marco Agizza on 27/10/22.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var goal : Goal
    @State var index : Int
    @Binding var mode : EditMode
    
    var body: some View {
        if index < goal.taskList.count {
            VStack{
                HStack{
                    mode == .inactive ? Image(systemName: goal.taskList[index].doneStatus ? "checkmark.circle" : "circle")
                        .font(.system(size: 20))
                        .foregroundColor(goal.taskList[index].doneStatus ? Color(UIColor.white) : Color.secondary)
                        .onTapGesture {
                            if goal.taskList[index].doneStatus == true {
                                if index < goal.taskList.count-1 && goal.taskList[index+1].doneStatus == true {
                                    return
                                }
                            } else {
                                if index > 0 && goal.taskList[index-1].doneStatus == false{
                                    return
                                }
                            }
                            goal.taskList[index].doneStatus.toggle()
                        } : nil
                    Text(goal.taskList[index].title)
                    Spacer()
                }
                HStack{
                    VStack{
                        /*
                         Image(systemName: task.doneStatus ? "circle.fill" : "circle")
                         .resizable()
                         .frame(width: 10.0, height: 10.0)
                         Image(systemName: task.doneStatus ? "circle.fill" : "circle")
                         .resizable()
                         .frame(width: 10.0, height: 10.0)
                         Image(systemName: task.doneStatus ? "circle.fill" : "circle")
                         .resizable()
                         .frame(width: 10.0, height: 10.0)
                         */
                    }
                    .padding(.leading, 4)
                    .padding(/*@START_MENU_TOKEN@*/.bottom, -10.0/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
            }
        }
    }
}

struct CheckBoxViewList: View {
    @Binding var goal : Goal
    @Binding var mode : EditMode
    @Binding var currTaskTitle : String
    
    var body: some View {
        ZStack {
            goal.isPrimary ? Color("PrimaryCardColor").ignoresSafeArea() : Color("SecondaryCardColor").ignoresSafeArea()
            List {
                ForEach(0..<goal.taskList.count, id: \.self) { index in
                    CheckBoxView(goal: $goal, index: index, mode: $mode)
                }
                .onDelete(perform: goal.taskList.count > 1 ? delete : nil)
                .onMove(perform: move)
                .listRowBackground(Color.gray.opacity(0.0))
                .listRowSeparator(.hidden)
                mode == .inactive ? nil : HStack {
                    Image(systemName: "plus.circle.fill").font(.system(size: 20)).foregroundColor(.green)
                        .padding(.trailing, 6)
                    TextField("Write a new task", text: $currTaskTitle)
                }
                .listRowBackground(Color.gray.opacity(0.0))
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
        }
    }
    
    //TODO change delete and move using the ViewModel!
    func delete(at offset: IndexSet){
        if goal.taskList.count > 1 {
            if let first = offset.first {
                goal.removeTask(index: first)
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int){
        if destination < self.goal.taskList.count {
            let revesedSource = source.sorted()
            print("moving task from \(revesedSource) to \(destination)")
            for index in revesedSource.reversed() {
                goal.taskList.insert(goal.taskList.remove(at: index), at: destination)
            }
        }
    }
}

struct GoalDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var goalVM : GoalViewModel
    @State var goal : Goal
    @State var mode : EditMode = .inactive
    @State var currTaskTitle : String = String()
    @State var isFocusMode: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                goal.isPrimary ? Color("PrimaryCardColor").ignoresSafeArea() : Color("SecondaryCardColor").ignoresSafeArea()
                VStack {
                    HStack {
                        Text(goal.description).multilineTextAlignment(.leading)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.top, 12.0)
                    .padding(.leading)
                    .padding(.bottom, +15.0)
                    HStack {
                        Text("Tasks:")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.bottom, 10.0)
                    
                    
                    CheckBoxViewList(goal: $goal, mode: $mode, currTaskTitle: $currTaskTitle)
                        .listRowBackground(Color.gray.opacity(0.0))
                        .listRowSeparator(.hidden)
                        .padding(.top, -3)
                }
                VStack {
                    Spacer(minLength: 580)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color("PrimaryAccentColor"))
                            .ignoresSafeArea()
                        HStack {
                            Spacer()
                            Button {
                                if !goal.isCompleted {
                                    isFocusMode.toggle()
                                }
                            } label: {
                                ZStack{
                                    Capsule()
                                        .foregroundColor(Color("StartButtonMainColor"))
                                        .frame(width: 116, height: 60)
                                    Text("START")
                                        .bold()
                                        .foregroundColor(.white)
                                }
                            }
                            //                            NavigationLink(destination: FocusModeView(currentGoal: $goalVM.goals[goalVM.selectedGoal]), label: {
                            //                                ZStack{
                            //                                    Capsule()
                            //                                        .foregroundColor(Color("StartButtonMainColor"))
                            //                                        .frame(width: 116, height: 60)
                            //                                    Text("START")
                            //                                    .bold()
                            //                                    .foregroundColor(.white)
                            //                                }
                            //                            })
                            .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 15))
                            .fullScreenCover(isPresented: $isFocusMode) {
                                FocusModeView(goalVM: goalVM, currentGoal: $goal)
                            }
                        }
                    }
                }
            }
            .navigationTitle(goal.title)
            .navigationBarItems(
                leading: Button {
                    dismiss()
                } label: {
                    Label("Close page", systemImage: "xmark.circle.fill").font(.system(size: 22))
                }.foregroundColor(.white),
                trailing: EditButton()
                    .fontWeight(.semibold)
                    .padding(.trailing, 8)
                    .background(.white)
                    .foregroundColor(goal.isPrimary ? Color("PrimaryCardColor") : Color("SecondaryCardColor"))
                    .cornerRadius(33)
            )
            .environment(\.editMode, $mode)
            .onSubmit {
                addTaskToTheList()
            }
            .onDisappear {
                goalVM.goals[goalVM.selectedGoal] = goal
            }
        }
    }
    
    func addTaskToTheList(){
        guard currTaskTitle.count > 0 else { return }
        goal.addTask(taskTitle: currTaskTitle)
        currTaskTitle = ""
        
    }
}

//struct GoalStartButtonView: View {
//    var body: some View {
//
//    }
//}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailsView(goalVM: GoalViewModel(), goal: goalData[0])
    }
}

