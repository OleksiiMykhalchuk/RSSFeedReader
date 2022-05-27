//
//  DetailsViewModel.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/27/22.
//

import Foundation

extension DetailsViewController {
    class ViewModel {
        weak var coordinator: AppCoordinator?
        var details: DetailsViewModel?
        func start() {
            
        }
        func viewModel(with data: ListCellViewModel) {
            details = DetailsViewModel(title: data.title, description: data.description)
        }
    }
}

struct DetailsViewModel {
    let title: String
    let description: String
}
