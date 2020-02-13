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
    let midnightBlue = Color(red: 0.0/255.0, green: 0.0/51.0, blue: 102.0/255.0)
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18 ))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12 ))
        }
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 18 ))
                .modifier(ShadowStyle())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .modifier(ShadowStyle())
        }
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            
            Spacer()
            
            // Slider row
            HStack{
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            
            // Button row
            Button(action: {
                self.alertIsVisible = true
            })
            {
                Text("Hit Me!").modifier(ButtonLargeTextStyle())
                
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
            .background(Image("Button").modifier(ShadowStyle()))
            
            Spacer()
            
            // Score row
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    HStack{
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                    
                }.background(Image("Button").modifier(ShadowStyle()))
                
                Spacer()
                
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                
                Spacer()

                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                    
                }.background(Image("Button").modifier(ShadowStyle()))
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
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
