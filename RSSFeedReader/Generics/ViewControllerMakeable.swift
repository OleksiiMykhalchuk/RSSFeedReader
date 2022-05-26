//
//  ViewControllerMakeable.swift
//  RSSFeedReader
//
//  Created by Denysov Illia on 26.05.2022.
//

import Foundation
import UIKit

protocol ViewControllerMakeable: AnyObject {
}

extension ViewControllerMakeable where Self: ViewModelApplyied, Self: UIViewController {
    static func make(viewModel: ViewModel) -> Self {
        var viewController = Self()
        viewController.viewModel = viewModel
        return viewController
    }
}
