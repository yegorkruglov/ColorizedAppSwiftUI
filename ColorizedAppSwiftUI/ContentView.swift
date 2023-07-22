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
    @State private var alertPresented = false

    enum Field {
        case red, green, blue
    }
    
    @FocusState private var focusField: Field?
    
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
                    .focused($focusField, equals: .red)
                SliderStackView(colorCompanment: $green, colorOfText: .green)
                    .focused($focusField, equals: .green)
                SliderStackView(colorCompanment: $blue, colorOfText: .blue)
                    .focused($focusField, equals: .blue)
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button {
                        switch focusField {
                        case .red:
                            focusField = .blue
                        case .green:
                            focusField = .red
                        case .blue:
                            focusField = .green
                        case .none:
                            focusField = .red
                        }
                    } label: {
                        Image(systemName: "chevron.up")
                    }

                    Button {
                        switch focusField {
                        case .red:
                            focusField = .green
                        case .green:
                            focusField = .blue
                        case .blue:
                            focusField = .red
                        case .none:
                            focusField = .red
                        }
                        
                    } label: {
                        Image(systemName: "chevron.down")
                    }

                    
                    Spacer()
                    
                    Button("Done") {
                        checkData()
                    }
                    .alert("Wrong format", isPresented: $alertPresented, actions: {}) {
                        Text("Value must be in a range 0...255")
                    }
                }
            }
        }
    }
    
    private func checkData() {
        if !(0...255).contains(red) || !(0...255).contains(green) || !(0...255).contains(blue) {
            alertPresented.toggle()
            return
        }
        focusField = nil
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
