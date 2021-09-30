//
//  UIColorFormatStyle.swift
//  CustomParseableFormatStyleDemo
//
//  Created by Yang Xu on 2021/9/29.
//

import Foundation
import UIKit

struct UIColorFormatStyle: ParseableFormatStyle {
    var parseStrategy: UIColorParseStrategy {
        UIColorParseStrategy()
    }

    private var alpha: Alpha = .none
    private var prefix: Prefix = .hashtag
    private var mark: Mark = .none
    private var locale: Locale = .current

    var attributed: Attributed {
        Attributed(prefix: prefix, alpha: alpha,mark: mark,locale: locale)
    }

    enum Prefix: Codable {
        case hashtag
        case none
    }

    enum Alpha: Codable {
        case show
        case none
    }

    enum Mark: Codable {
        case show
        case none
    }

    init(prefix: Prefix = .hashtag, alpha: Alpha = .none, mark: Mark = .none, locale: Locale = .current) {
        self.prefix = prefix
        self.alpha = alpha
        self.mark = mark
        self.locale = locale
    }

    func format(_ value: UIColor) -> String {
        let (prefix, red, green, blue, alpha, redMark, greenMark, blueMark, alphaMark) = Self.getField(value, prefix: prefix, alpha: alpha, mark: mark, locale: locale)
        return prefix + redMark + red + greenMark + green + blueMark + blue + alphaMark + alpha
    }
}

extension UIColorFormatStyle {
    func prefix(_ value: Prefix = .hashtag) -> Self {
        guard prefix != value else { return self }
        var result = self
        result.prefix = value
        return result
    }

    func alpah(_ value: Alpha = .show) -> Self {
        guard alpha != value else { return self }
        var result = self
        result.alpha = value
        return result
    }

    func mark(_ value: Mark = .show) -> Self {
        guard mark != value else { return self }
        var result = self
        result.mark = value
        return result
    }

    func locale(_ locale: Locale) -> UIColorFormatStyle {
        guard self.locale != locale else { return self }
        var result = self
        result.locale = locale
        return result
    }
}

extension UIColorFormatStyle {
    static func getField(_ color: UIColor, prefix: Prefix, alpha: Alpha, mark: Mark, locale: Locale) -> (prefix: String, red: String, green: String, blue: String, alpha: String, redMask: String, greenMark: String, blueMark: String, alphaMark: String) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        let formatString = "%02X"
        let prefix = prefix == .hashtag ? "#" : ""
        let red = String(format: formatString, Int(r * 0xff))
        let green = String(format: formatString, Int(g * 0xff))
        let blue = String(format: formatString, Int(b * 0xff))
        let alphaString = alpha == .show ? String(format: formatString, Int(a * 0xff)) : ""

        var redMark = ""
        var greenMark = ""
        var blueMark = ""
        var alphaMark = ""

        if mark == .show {
            redMark = String(localized: "UIColorRedMark", locale: locale)
            greenMark = String(localized: "UIColorGreenMark", locale: locale)
            blueMark = String(localized: "UIColorBlueMark", locale: locale)
            alphaMark = alpha == .show ? String(localized: "UIColorAlphaMark", locale: locale) : ""
        }

        return (prefix, red, green, blue, alphaString, redMark, greenMark, blueMark, alphaMark)
    }
}
