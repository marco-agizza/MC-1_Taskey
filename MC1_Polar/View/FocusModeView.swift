//
//  FocusModeView.swift
//  MC1_Polar
//
//  Created by Ciro Forchetta on 24/10/22.
//

import SwiftUI

struct FocusModeView: View {
@State var TimeRemaining = 2700

    @State var isStopped = false
    var timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    func convertSecondToTime(timeInSeconds : Int) ->
    String {
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i",minutes,seconds)
    }
var body: some View {
         
     VStack {
           Text(convertSecondToTime(timeInSeconds:   TimeRemaining))
                .padding()
                .font(.system(size:100))
                .onReceive(timer) { _ in
              TimeRemaining -= 1
                    
                }
        HStack(spacing : 30){
            Button("pause"){
               if (isStopped){

                   isStopped=false
                }
                else{
                    timer.upstream.connect().cancel()

                  isStopped=true
                }

                 
             }
         Button("reset"){
               TimeRemaining = 2700
                 
             }
         }
            
      
        }
        
        
           }
    
    
    
      }

struct focusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusModeView()
    }
}
