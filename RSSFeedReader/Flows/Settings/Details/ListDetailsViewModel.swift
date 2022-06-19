//
//  ListDetailsViewModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 6/19/22.
//

import Foundation

extension LinkDetailsViewController {
    class ViewModel {
        weak var coordinator: AppCoordinator?
        lazy var dataManager: DataManager = .init()
        var item: RSSUrl!
        func viewModel(with data: RSSUrl) {
            item = data
        }
    }
}
