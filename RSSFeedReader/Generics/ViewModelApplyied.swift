//
//  ViewModelApplyied.swift
//  RSSFeedReader
//
//  Created by Denysov Illia on 26.05.2022.
//

import Foundation

protocol ViewModelApplyied {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
}
