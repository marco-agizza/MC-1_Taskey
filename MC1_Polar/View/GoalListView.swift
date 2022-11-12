//
//  GoalList.swift
//  MC1_Polar
//
//  Created by Ilia Sedelkin on 21/10/22.
//

import SwiftUI

struct GoalList: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("PrimaryCardColor"))
                .frame(height: 210)
                .padding()
            HStack{
                VStack (alignment: .leading){
                    Text("Your main goal:")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Looking for a Job")
                        .font(.title)
                        .foregroundColor(.white)
                    
                }
                .padding(.leading, 50)
                Spacer()
            }
            
        }
        Spacer()
    }
}

struct GoalList_Previews: PreviewProvider {
    static var previews: some View {
        GoalList()
    }
}
