//
//  SettingsViewController.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 6/7/22.
//

import UIKit

class SettingsViewController: UIViewController, ViewModelApplyied, ViewControllerMakeable {
    var viewModel: ViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseButton()
        addTextField()
    }
    private func addCloseButton() {
        let btn = UIButton(type: .system)
        btn.setTitle("Close", for: .normal)
        btn.frame = CGRect(x: view.frame.width - 75, y: 15, width: 60, height: 30)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    @objc func close(sender: Any) {
        dismiss(animated: true)
    }
    private func addTextField() {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Insert RSS Link"
        view.addSubview(textField)
        let constraints = [textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
                           textField.heightAnchor.constraint(equalToConstant: 50),
                           textField.widthAnchor.constraint(equalToConstant: view.bounds.size.width-30),
                           textField.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
