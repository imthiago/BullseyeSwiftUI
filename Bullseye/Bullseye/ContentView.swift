//
//  ContentView.swift
//  Bullseye
//
//  Created by Thiago Oliveira on 11/02/20.
//  Copyright © 2020 Thiago Oliveira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    
    var body: some View {
        
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(target)")
            }
            
            Spacer()
            
            // Slider row
            HStack{
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            
            // Button row
            Button(action: {
                self.alertIsVisible = true
            })
            {
                Text("Hit Me!")
                
            }
            .alert(isPresented: $alertIsVisible){() ->
                Alert in
                return Alert(
                    title: Text(alertTitle()),
                    message: Text(
                        "The slider's value is \(sliderValueRounded()).\n" +
                        "You sccore \(pointsCurrentRound()) points this round."),
                    dismissButton: .default(Text("Awesome!")){
                        self.score += self.pointsCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.round += 1
                    })
            }
            
            Spacer()
            
            // Score row
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
                Text("\(score)")
                Text("Round:")
                Text("\(round)")
                Spacer()

                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
            
        }
    }
    
    func alertTitle() -> String {
        
        if ammountOff() == 0 {
            return "Perfect!"
        } else if ammountOff() < 5 {
            return "You almost had it!"
        }
        return "Are you even trying?"
    }
    
    func ammountOff() -> Int {
        abs(sliderValueRounded() - target)
    }
    
    func sliderValueRounded() -> Int{
        Int(sliderValue.rounded())
    }
    
    func pointsCurrentRound() -> Int {
        
        if ammountOff() == 0 {
            return 100 - ammountOff() + 100
        } else if ammountOff() == 1 {
            return 100 - ammountOff() + 50
        }

        return 100 - ammountOff()
    }
    
    func startNewGame() {
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
