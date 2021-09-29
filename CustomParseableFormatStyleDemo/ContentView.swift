//
//  ContentView.swift
//  CustomParseableFormatStyleDemo
//
//  Created by Yang Xu on 2021/9/29.
//

import SwiftUI

struct ContentView: View {
    @State var color: UIColor = .red
    var cgColor: Binding<CGColor> {
        Binding<CGColor>(
            get: { color.cgColor },
            set: { color = UIColor(cgColor: $0) }
        )
    }

    var body: some View {
        NavigationView {
            Form {
                Section("String") {
                    Text(color, format: .uiColor)
                }
                Section("AttributedString") {
                    Text(colorAttributeString)
                }
                Section("TextField") {
                    TextField("color:", value: $color, format: .uiColor.prefix(.none))
                        .autocapitalization(.allCharacters)
                    Rectangle().fill(Color(color))
                        .overlay(Text(color, format: .uiColor.alpah().mark()))
                    ColorPicker("颜色选择", selection: cgColor, supportsOpacity: true)
                }
            }
            .navigationTitle("自定义FormatStyle演示")
        }
    }

    var colorAttributeString: AttributedString {
        var attributedString = color.formatted(.uiColor.attributed)
        let prefixContainer = AttributeContainer().colorPart(.prefix)
        var secondaryColorContainer = AttributeContainer()
        secondaryColorContainer.foregroundColor = .secondary

        let redContainer = AttributeContainer().colorPart(.red)
        var redColorContainer = AttributeContainer()
        redColorContainer.foregroundColor = .red

        let greenContainer = AttributeContainer().colorPart(.green)
        var greenColorContainer = AttributeContainer()
        greenColorContainer.foregroundColor = .green

        let blueContainer = AttributeContainer().colorPart(.blue)
        var blueColorContainer = AttributeContainer()
        blueColorContainer.foregroundColor = .blue

        let alpheContainer = AttributeContainer().colorPart(.alpha)
        var alphaColorContainer = AttributeContainer()
        alphaColorContainer.foregroundColor = .gray

        attributedString.replaceAttributes(prefixContainer, with: secondaryColorContainer)
        attributedString.replaceAttributes(redContainer, with: redColorContainer)
        attributedString.replaceAttributes(greenContainer, with: greenColorContainer)
        attributedString.replaceAttributes(blueContainer, with: blueColorContainer)
        attributedString.replaceAttributes(alpheContainer, with: alphaColorContainer)

        return attributedString
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
