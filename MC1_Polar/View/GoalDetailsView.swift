//
//  GoalDetailsView.swift
//  MC1_Polar
//
//  Created by Marco Agizza on 27/10/22.
//

import SwiftUI

struct CheckBoxView: View {
    @State var task : Task
    var body: some View {
        VStack{
            HStack{
                Image(systemName: task.doneStatus ? "checkmark.circle" : "circle")
                    .foregroundColor(task.doneStatus ? Color(UIColor.white) : Color.secondary)
                    .onTapGesture {
                        task.doneStatus.toggle()
                    }
                Text(task.title)
                Spacer()
            }
            HStack{
                VStack{
                    Image(systemName: task.doneStatus ? "circle.fill" : "circle")
                        .resizable()
                        .frame(width: 10.0, height: 10.0)
                    Image(systemName: task.doneStatus ? "circle.fill" : "circle")
                        .resizable()
                        .frame(width: 10.0, height: 10.0)
                    Image(systemName: task.doneStatus ? "circle.fill" : "circle")
                        .resizable()
                        .frame(width: 10.0, height: 10.0)
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
    
    var body: some View {
        ZStack {
            goal.isPrimary ? Color("PrimaryCardColor").ignoresSafeArea() : Color("SecondaryCardColor").ignoresSafeArea()
            List {
                ForEach(goal.taskList) { task in
                    CheckBoxView(task: task)
                }
                .listRowBackground(Color.gray.opacity(0.0))
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
        }
    }
}

struct GoalDetailsView: View {
    @State var goal : Goal
    
    var body: some View {
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
                
                
                    CheckBoxViewList(goal: goal)
                        .listRowBackground(Color.gray.opacity(0.0))
                        .listRowSeparator(.hidden)
                        .padding(.top, -3)
            }
        }
        .navigationTitle(goal.title)
    }
    
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailsView(goal: goalData[0])
    }
}
