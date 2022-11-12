//
//  GoalDetailsView.swift
//  MC1_Taskey
//  Polar
//
//  Created by Marco Agizza on 27/10/22.
//

import SwiftUI

struct CheckBoxView: View {
    @State var task : Task
    @Binding var mode : EditMode
    var body: some View {
        VStack{
            HStack{
                mode == .inactive ? Image(systemName: task.doneStatus ? "checkmark.circle" : "circle").font(.system(size: 20))
                    .foregroundColor(task.doneStatus ? Color(UIColor.white) : Color.secondary)
                    .onTapGesture {
                        task.doneStatus.toggle()
                    } : nil
                Text(task.title)
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

struct CheckBoxViewList: View {
    @State var goal : Goal
    @Binding var mode : EditMode
    @Binding var currTaskTitle : String
    
    var body: some View {
        ZStack {
            goal.isPrimary ? Color("PrimaryCardColor").ignoresSafeArea() : Color("SecondaryCardColor").ignoresSafeArea()
            List {
                ForEach(goal.taskList) { task in
                    CheckBoxView(task: task, mode: $mode)
                }
                .onDelete(perform: delete)
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
        if let first = offset.first{
            goal.taskList.remove(at: first)
        }
    }
    
    func move(from source: IndexSet, to destination: Int){
        let revesedSource = source.sorted()
        for index in revesedSource.reversed(){
            goal.taskList.insert(goal.taskList.remove(at: index), at: destination)
        }
    }
}

struct GoalDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State var goal : Goal
    @State fileprivate var isEditing : Bool = false
    @State var mode : EditMode = .inactive
    @State var currTaskTitle : String = String()
    var body: some View {
        NavigationView {
            ZStack {
                goal.isPrimary ? Color("PrimaryCardColor").ignoresSafeArea() : Color("SecondaryCardColor").ignoresSafeArea()
                VStack {
                    HStack{
                        Text(goal.description).multilineTextAlignment(.leading)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.top, -2.0)
                    .padding(.leading)
                    .padding(.bottom, +15.0)
                    HStack{
                        Text("Tasks:")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.bottom, 10.0)
                    
                    
                    CheckBoxViewList(goal: goal, mode: $mode, currTaskTitle: $currTaskTitle)
                        .listRowBackground(Color.gray.opacity(0.0))
                        .listRowSeparator(.hidden)
                        .padding(.top, -3)
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
                    /*Button() {
                    isEditing.toggle()
                } label: {
                    //Label("Edit goal", systemImage: "pencil.circle.fill").font(.system(size: 22))
                    isEditing ?
                    Text("Done")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3.6)
                        .background(.white)
                        .foregroundColor(goal.isPrimary ? Color("PrimaryCardColor") : Color("SecondaryCardColor"))
                        .cornerRadius(33):
                    Text("Edit")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3.6)
                        .background(.white)
                        .foregroundColor(goal.isPrimary ? Color("PrimaryCardColor") : Color("SecondaryCardColor"))
                        .cornerRadius(33)
                    
                }.foregroundColor(.white)*/
            )
            .environment(\.editMode, $mode)
            .onSubmit {
                addTaskToTheList()
            }
        }
    }
    
    func addTaskToTheList(){
        guard currTaskTitle.count > 0 else { return }
        //taskVM.addTask(newTaskTitle: currTaskTitle)
        currTaskTitle = ""
        
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailsView(goal: goalData[0])
    }
}
