//
//  GoalCreationView.swift
//  MC1_Taskey
//  Polar
//
//  Created by Marco Agizza on 19/10/22.
//

import SwiftUI


struct GoalCreationView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var taskVM = TaskViewModel()
    
    @State var goalTitle : String
    @State var goalDescription : String
    @State var currTaskTitle : String
    @State var goalVM : GoalViewModel
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("Goal", text: $goalTitle)
                    .font(.title)
                TextField("Motivation: what drives this goal?", text: $goalDescription)
                    .font(.headline)
                    .padding(.bottom, 16)
                HStack{
                    Text("Tasks:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .dynamicTypeSize(.large)
                    Spacer()
                }
                // TODO implement the delete swipe
                List {
                    ForEach(taskVM.tasks){ task in
                        Text(task.title)
                    }
                    .onDelete(perform: taskVM.remove)
                    // TODO check the number of list items to change the text in the button
                    HStack {
                        Image(systemName: "plus.app")
                        TextField("Write a new task", text: $currTaskTitle)
                    }
                }
                .listStyle(.inset)
                Spacer()
            }
            .navigationTitle("Set a new goal")
            .padding()
            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .navigationBarItems(
                leading: Button("Cancel"){
                    dismiss()
                },
                //Add the task number condition to disable the button
                trailing: Button("Done"){
                    print("Creating a new goal")
                    goalVM.addGoal(
                        newGoal: Goal(title: goalTitle, description: goalDescription, taskList: taskVM.tasks)
                    )
                    dismiss()
                }
                    .disabled(goalTitle.isEmpty || goalDescription.isEmpty || taskVM.tasks.isEmpty)
                )
            .onSubmit {
                addTaskToTheList()
            }
        }
    }
    
    func addTaskToTheList(){
        guard currTaskTitle.count > 0 else { return }
        taskVM.addTask(newTaskTitle: currTaskTitle)
        currTaskTitle = ""
        
    }
    
}

struct GoalCreationView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCreationView(goalTitle: "Goal", goalDescription: "Motivation: what drives this goal?", currTaskTitle: "donnow", goalVM: GoalViewModel())
    }
}
