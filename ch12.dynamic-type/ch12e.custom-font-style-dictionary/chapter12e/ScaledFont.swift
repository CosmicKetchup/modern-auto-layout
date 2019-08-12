//
//  ScaledFont.swift
//  chapter12e
//
//  Created by Matt Brown on 7/31/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

// Keith Harrison - https://useyourloaf.com/autolayout/
public struct ScaledFont {
    
    fileprivate struct FontDescription: Decodable {
        let fontName: String
        let fontSize: CGFloat
    }
    
    fileprivate typealias StyleDictionary = [UIFont.TextStyle.RawValue: FontDescription]
    fileprivate var styleDictionary: StyleDictionary?
    
    public init(fontName: String, in bundle: Bundle = Bundle.main) {
        if let url = bundle.url(forResource: fontName, withExtension: "plist"), let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            styleDictionary = try? decoder.decode(StyleDictionary.self, from: data)
        }
    }
    
    public func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        guard let fontDescription = styleDictionary?[textStyle.rawValue],
            let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize) else { return UIFont.preferredFont(forTextStyle: textStyle) }
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: font)
    }
}
