//
//  LinkDetailsViewController.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 6/19/22.
//

import UIKit
import SwiftUI

class LinkDetailsViewController: UIViewController, ViewModelApplyied, ViewControllerMakeable {
    var viewModel: ViewModel!
    private var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit the Link"
        addTextField()
        addBarButton()
        textField.text = viewModel.item.url
    }
    private func addTextField() {
        textField = UITextView()
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.layer.borderWidth = 1
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            textField.heightAnchor.constraint(equalToConstant: 200)]
        NSLayoutConstraint.activate(constraints)
    }
    private func addBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done))
    }
    @objc func done(sender: Any) {
        viewModel.dataManager.updateLink(item: viewModel.item, with: textField.text) { result in
            switch result {
            case .success(_):
                print("Updated")
            case .failure(_):
                print("Error")
            }
        }
        UserDefaults.standard.removeObject(forKey: "pubDate")
        navigationController?.popViewController(animated: true)
    }
}
