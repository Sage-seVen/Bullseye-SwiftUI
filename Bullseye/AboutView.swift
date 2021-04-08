//
//  AboutView.swift
//  Bullseye
//
//  Created by Sahil Sagar on 26/11/19.
//  Copyright © 2019 Sage_seVen. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let customcolor = Color(red:255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    struct Heading: ViewModifier{
        func body(content :Content)-> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("ArialRoundedMTBold", size:30))
                .padding(.top,20)
                .padding(.bottom,20)
        }
    }
    
    struct TextStyle: ViewModifier{
        func body(content :Content)-> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("ArialRoundedMTBold", size:16))
                .padding(.top,20)
                .padding(.bottom,20)
                .padding(.leading,20)
                .padding(.trailing,20)
        }
    }
    
    
    
    var body: some View {
        VStack {
            Spacer()
            Text("Bullseye 🎯").modifier(Heading())
            Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider. ").modifier(TextStyle())
            Text("Your Goal is to place the slider as close as possible to the Target. ENJOY!! 👽 " ).modifier(TextStyle())
            Spacer()
            VStack{
                Text("Sage_seVen").modifier(TextStyle())
            }
        }
//    .background(customcolor)
    .background(Image("Background"), alignment: .center)
    .navigationBarTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
