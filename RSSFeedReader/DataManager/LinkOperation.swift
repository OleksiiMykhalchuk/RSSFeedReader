//
//  LinkOperation.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 6/14/22.
//

import UIKit

final class LinkOperation: Operation {
    private var url: URL
    private static let context = CIContext()
    init(url: URL) {
        self.url = url
        super.init()
    }
    override func main() {
        
    }
}
