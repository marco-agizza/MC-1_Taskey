//
//  RoundButton.swift
//  Taskey
//
//  Created by Ilia Sedelkin on 13/11/22.
//

import SwiftUI

struct RoundButton: View {
    
    let buttonColor: String
    let buttonSymbol: String
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(buttonColor))
                .frame(width: 91)
            Image(systemName: buttonSymbol)
                .resizable()
                .frame(width: 45, height: 45)
        }
        .onTapGesture(perform: action)
    }
    
    init(buttonColor: String, buttonSymbol: String, onTap: @escaping () -> Void) {
        self.buttonColor = buttonColor
        self.buttonSymbol = buttonSymbol
        self.action = onTap
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
//            pauseRoundButton
//            playRoundButton
//            stopRoundButton
        }
    }
}
