//
//  NSAttributedString.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/27/22.
//

import Foundation

extension NSAttributedString {
    class func attributedString(string: String) -> NSAttributedString {
        let data = string.data(using: .utf8)
        var attributedString = NSAttributedString()
        if let data = data {
            do {
                 attributedString = try NSAttributedString(
                    data: data,
                    options: [.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
            } catch {
                print("NSAttributedString Error \(error)")
            }
        }
        return attributedString
    }
}
