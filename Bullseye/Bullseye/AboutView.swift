//
//  AboutView.swift
//  Bullseye
//
//  Created by Thiago Oliveira on 12/02/20.
//  Copyright © 2020 Thiago Oliveira. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let beige = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    struct HeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(Color.black)
                .padding(.bottom, 20)
                .padding(.top, 20)
        }
    }
    
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(HeadingStyle())
                Text("This is Bullseye, the gme where you can win points and earn fame by dragging a slider.").modifier(TextStyle()).lineLimit(nil)
                Text("You goal is to place the slider as close as possible to the target value.\n The closer you are, the more points you score.").modifier(TextStyle()).lineLimit(nil)
                Text("Enjoy!").modifier(TextStyle()).lineLimit(nil)
            }
        .navigationBarTitle("About Bullseye")
        .background(beige)
        }
    .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
