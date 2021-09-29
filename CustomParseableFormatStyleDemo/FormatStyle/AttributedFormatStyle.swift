//
//  AttributedFormatStyle.swift
//  CustomParseableFormatStyleDemo
//
//  Created by Yang Xu on 2021/9/29.
//

import Foundation
import UIKit

extension UIColorFormatStyle {
    struct Attributed: Codable, Hashable, FormatStyle {
        private var alpha: Alpha = .none
        private var prefix: Prefix = .hashtag
        private var mark: Mark = .none
        private var locale: Locale = .current

        init(prefix: Prefix = .hashtag, alpha: Alpha = .none, mark: Mark = .none, locale: Locale = .current) {
            self.prefix = prefix
            self.alpha = alpha
            self.mark = mark
            self.locale = locale
        }

        func format(_ value: UIColor) -> AttributedString {
            let (prefix, red, green, blue, alpha, redMark, greenMark, blueMark, alphaMark) = UIColorFormatStyle.getField(value, prefix: prefix, alpha: alpha, mark: mark, locale: locale)
            let prefixString = AttributedString(localized: "^[\(prefix)](colorPart:'prefix')", including: \.myApp)
            let redString = AttributedString(localized: "^[\(red)](colorPart:'red')", including: \.myApp)
            let greenString = AttributedString(localized: "^[\(green)](colorPart:'green')", including: \.myApp)
            let blueString = AttributedString(localized: "^[\(blue)](colorPart:'blue')", including: \.myApp)
            let alphaString = AttributedString(localized: "^[\(alpha)](colorPart:'alpha')", including: \.myApp)

            let redMarkString = AttributedString(localized: "^[\(redMark)](colorPart:'mark')", including: \.myApp)
            let greenMarkString = AttributedString(localized: "^[\(greenMark)](colorPart:'mark')", including: \.myApp)
            let blueMarkString = AttributedString(localized: "^[\(blueMark)](colorPart:'mark')", including: \.myApp)
            let alphaMarkString = AttributedString(localized: "^[\(alphaMark)](colorPart:'mark')", including: \.myApp)

            let result = prefixString + redMarkString + redString + greenMarkString + greenString + blueMarkString + blueString + alphaMarkString + alphaString
            return result
        }

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
    }
}
