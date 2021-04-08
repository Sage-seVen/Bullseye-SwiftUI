//
//  ContentView.swift
//  Bullseye
//
//  Created by Sahil Sagar on 25/11/19.
//  Copyright © 2019 Sage_seVen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target: Int = Int.random(in: 1...100)
    @State var score: Int = 0
    @State var roundNo: Int = 1
    let midnightblue = Color(red:0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    struct LabelStyle: ViewModifier{
        func body(content :Content)-> some View{
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("ArialRoundedMTBold", size:18))
        }
    }
    
    struct ViewStyle: ViewModifier{
        func body(content :Content)-> some View{
            return content
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
                .font(Font.custom("ArialRoundedMTBold", size:24))
        }
    }
    
    struct Shadow: ViewModifier{
        func body(content :Content)-> some View{
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLTextStyle: ViewModifier{
        func body(content :Content)-> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("ArialRoundedMTBold", size:18))
        }
    }
    
    struct ButtonSTextStyle: ViewModifier{
        func body(content :Content)-> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("ArialRoundedMTBold", size:12))
        }
    }
    
    
    func scoreCalc () -> Int{
        let bonus :Int
        if difference() == 0 {
            bonus = 100
        }
        else if difference()<5{
            bonus = 50
        }
        else{
        bonus = 0
        }
        return 100 - difference() + bonus
    }
    
    func difference () -> Int{
        return abs(self.target - Int(self.sliderValue.rounded()))
    }
    
    func alertTitle() -> String{
        if difference()==0{
            return "Perfect!"
        }
        else if difference()<5{
            return "Very Close!"
        }
        else if difference()<=10{
            return "Not Bad!"
        }
        return "Nowhere Close"
    }
    
    func startOver(){
        score = 0
        roundNo = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
    
var body: some View {
    
        VStack {
            //target row
            Spacer()
            HStack {
                Text("Put the Bullseye as close as you can to: ").modifier(LabelStyle())
                Text("\(self.target)").modifier(ViewStyle())
            }
            Spacer()
            
            
            //slider row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in:1...100).accentColor(Color.green) //dollar is used to bind data and state
                //Text("\(self.sliderValue)")
                Text("100").modifier(LabelStyle())
            }
            Spacer()
//            Text("\(Int(self.sliderValue.rounded()))")
            
            
            //button row
            Button(action: {
                //print("Print in Console : Button Pressed")
                self.alertIsVisible=true //self. is name of current class
            }) {
                Text("Click me!").modifier(ButtonLTextStyle())
            }
            .alert(isPresented: $alertIsVisible){()->Alert in
                let roundedValue: Int = Int(self.sliderValue.rounded())
                return Alert(title: Text("I m Touched \(self.alertTitle())"), message: Text("The Slider value is: \(roundedValue) \n Your Score is: \(self.scoreCalc())"), dismissButton: .default(Text("Dismiss")) {
                    self.score+=self.scoreCalc()
                    self.roundNo+=1
                    self.target = Int.random(in: 1...100)
                    })
            }
            .background(Image("Button"), alignment: .center).modifier(Shadow())
            Spacer()
            //score row
            HStack {
                Button(action: { self.startOver() }) {
                    HStack{
                        Image("StartOverIcon")
                        Text("Start Over").modifier(ButtonSTextStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(self.score)").modifier(ViewStyle())
                Spacer()
                Text("Round").modifier(LabelStyle())
                Text("\(self.roundNo)").modifier(ViewStyle())
                Spacer()
                
                NavigationLink(destination: AboutView()){
                    HStack{
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSTextStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom,20)
        }
    .background(Image("Background"), alignment: .center)
    .accentColor(midnightblue)
    .navigationBarTitle("Bullseye")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
