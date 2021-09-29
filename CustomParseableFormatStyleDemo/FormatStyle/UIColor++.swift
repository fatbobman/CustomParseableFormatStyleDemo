//
//  UIColor++.swift
//  CustomParseableFormatStyleDemo
//
//  Created by Yang Xu on 2021/9/29.
//

import Foundation
import UIKit

extension UIColor {
    func formatted<F>(_ format: F) -> F.FormatOutput where F: FormatStyle, F.FormatInput == UIColor, F.FormatOutput == String {
        format.format(self)
    }

    func formatted<F>(_ format: F) -> F.FormatOutput where F: FormatStyle, F.FormatInput == UIColor, F.FormatOutput == AttributedString {
        format.format(self)
    }
}
