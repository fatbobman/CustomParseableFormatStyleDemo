//
//  FormatStyle++.swift
//  CustomParseableFormatStyleDemo
//
//  Created by Yang Xu on 2021/9/29.
//

import Foundation

extension FormatStyle where Self == UIColorFormatStyle.Attributed {
    static var uiColor: UIColorFormatStyle.Attributed {
        UIColorFormatStyle().attributed
    }
}

extension FormatStyle where Self == UIColorFormatStyle {
    static var uiColor: UIColorFormatStyle {
        UIColorFormatStyle()
    }
}
