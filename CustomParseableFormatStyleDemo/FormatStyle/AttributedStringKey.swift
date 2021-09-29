//
//  AttributedKey.swift
//  CustomParseableFormatStyleDemo
//
//  Created by Yang Xu on 2021/9/29.
//

import Foundation

enum UIColorAttirbute: CodableAttributedStringKey, MarkdownDecodableAttributedStringKey {
    enum Value: String, Codable {
        case red
        case green
        case blue
        case alpha
        case prefix
        case mark
    }

    static var name: String = "colorPart"
}

extension AttributeScopes {
    public struct UIColorAttributes: AttributeScope {
        let colorPart: UIColorAttirbute
    }

    var myApp: UIColorAttributes.Type { UIColorAttributes.self }
}

extension AttributeDynamicLookup {
    subscript<T>(dynamicMember keyPath: KeyPath<AttributeScopes.UIColorAttributes, T>) -> T where T: AttributedStringKey { self[T.self] }
}
