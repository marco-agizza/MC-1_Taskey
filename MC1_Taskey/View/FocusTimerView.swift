//
//  FocusTimerView.swift
//  Taskey
//
//  Created by Ilia Sedelkin on 13/11/22.
//

import SwiftUI

struct FocusTimerView: View {
    
    private var timeToSwitch: Int
    
    var body: some View {
                Text(convertSecondToTime(timeInSeconds: timeToSwitch))
                    .font(.system(size: 100))
                    .bold()
        }
    
    init(timeToSwitch: TimeInterval) {
        self.timeToSwitch = Int(timeToSwitch)
    }
    
    private func convertSecondToTime(timeInSeconds : Int) -> String {
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i",minutes,seconds)
    }
    
}

struct FocusTimerView_Previews: PreviewProvider {
    static var previews: some View {
        FocusTimerView(timeToSwitch: 2700)
    }
}
