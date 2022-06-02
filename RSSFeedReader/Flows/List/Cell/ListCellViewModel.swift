//
//  ListCellViewModel.swift
//  RSSFeedReader
//
//  Created by Denysov Illia on 26.05.2022.
//

import Foundation

struct ListCellViewModel {
    var title: String {
        rssItem.title
    }
    var description: String {
        rssItem.description
    }
    var pubDate: String {
        rssItem.pubDate
    }
    let rssItem: RSSItem
}
