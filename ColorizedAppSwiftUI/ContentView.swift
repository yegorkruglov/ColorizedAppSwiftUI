//
//  ContentView.swift
//  ColorizedAppSwiftUI
//
//  Created by Egor Kruglov on 21.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var red = Double.random(in: 0...255).rounded()
    @State private var green = Double.random(in: 0...255).rounded()
    @State private var blue = Double.random(in: 0...255).rounded()
    
    var body: some View {
        ZStack {
            Color(.lightGray)
                .ignoresSafeArea()
            
            
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(
                        red: red / 255,
                        green: green / 255,
                        blue: blue / 255)
                    )
                    .frame(height: 200)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 5)
                    }
                
                SliderStackView(colorCompanment: $red, colorOfText: .red)
                SliderStackView(colorCompanment: $green, colorOfText: .green)
                SliderStackView(colorCompanment: $blue, colorOfText: .blue)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SliderStackView: View {
    @Binding var colorCompanment: Double
    var colorOfText: Color
    
    var body: some View {
        HStack {
            Text("\(lround(colorCompanment))")
                .foregroundColor(colorOfText)
                .frame(width: 45)
            
            Slider(value: $colorCompanment, in: 0...255, step: 1)
            
            TextField("", value: $colorCompanment, format: .number)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 45)
                .keyboardType(.decimalPad)
            
            
            
        }
    }
}
