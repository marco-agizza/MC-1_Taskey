//
//  SecondaryCard.swift
//  MC1_Taskey
//  Polar
//
//  Created by Ilia Sedelkin on 25/10/22.
//

import SwiftUI

struct SecondaryCardView: View {
    
    var goal: Goal
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("SecondaryCardColor"))
                .frame(height: 92)
            HStack {
                VStack (alignment: .leading){
                    Text(goal.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.leading, 40)
                Spacer()
            }
            Spacer()
        }
    }
}

struct SecondaryCard_Previews: PreviewProvider {
    static var previews: some View {
        let newGoal = Goal(title: "Test", description: "Test", isPrimary: true)
        SecondaryCardView(goal: newGoal)
    }
}
