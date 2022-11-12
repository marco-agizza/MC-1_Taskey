//
//  PrimaryCardView.swift
//  MC1_Taskey
//  Polar
//
//  Created by Ilia Sedelkin on 21/10/22.
//

import SwiftUI

struct PrimaryCardView: View {
    
    var goal: Goal
    var count: Int = 0
    
    @State var i: Int = 0
    
    var body: some View {
        ZStack {
            //Color("BackgroundColor").ignoresSafeArea()
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("PrimaryCardColor"))
                .frame(height: 210)
            
            HStack{
                VStack (alignment: .leading){
                    Text("Your main goal:")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Text(goal.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    ForEach(goal.taskList.prefix(2)){ task in
                        HStack{
                            Label{
                                Text(task.title)
                            } icon: {
                                Image(systemName: task.doneStatus ? "checkmark.circle" : "circle")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    HStack{
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color("StartButtonMainColor"))
                                .frame(width: 75, height: 30)
                                
                            Button("START") {
                                
                            }
                            .bold()
                            .foregroundColor(.white)
                        }
                    }
                }
                .padding(.leading, 25)
                .padding(.vertical, 30)
                Spacer()
            }
            .frame(height: 210)
            .padding(.trailing, 20)
        }
    }
    
    func incrementIndex(num: Int)->Int{
        return num + 1
    }
}

struct PrimaryCard_Previews: PreviewProvider {
    static var previews: some View {
        let newGoal = Goal(title: "Test", description: "Test", taskList: taskData0, isPrimary: true)
        PrimaryCardView(goal: newGoal)
    }
}
