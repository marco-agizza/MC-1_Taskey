//
//  TextRectangleButton.swift
//  Taskey
//
//  Created by Ilia Sedelkin on 13/11/22.
//

import SwiftUI

struct TextRectangleButton: View {
    
    var buttonColor: String
    var buttonText: String
    var onTap: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 33)
                .foregroundColor(Color(buttonColor))
                .frame(width: 167, height: 91)
            Text(buttonText)
                .font(.title2)
                .bold()
        }
        .onTapGesture(perform: onTap)
    }
}

struct TextRectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {

        }
    }
}
