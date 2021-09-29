//
//  UIColorParseStrategy.swift
//  CustomParseableFormatStyleDemo
//
//  Created by Yang Xu on 2021/9/29.
//

import Foundation
import UIKit

struct UIColorParseStrategy: ParseStrategy {
    func parse(_ value: String) throws -> UIColor {
        var hexColor = value
        if value.hasPrefix("#") {
            let start = value.index(value.startIndex, offsetBy: 1)
            hexColor = String(value[start...])
        }

        if hexColor.count == 6 {
            hexColor += "FF"
        }

        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                return UIColor(red: CGFloat((hexNumber & 0xff000000) >> 24) / 255,
                               green: CGFloat((hexNumber & 0x00ff0000) >> 16) / 255,
                               blue: CGFloat((hexNumber & 0x0000ff00) >> 8) / 255,
                               alpha: CGFloat(hexNumber & 0x000000ff) / 255)
            }
        }

        throw Err.wrongColor
    }

    enum Err: Error {
        case wrongColor
    }
}
