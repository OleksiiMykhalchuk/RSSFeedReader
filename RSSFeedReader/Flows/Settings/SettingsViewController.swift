//
//  SettingsViewController.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 6/7/22.
//

import UIKit

class SettingsViewController: UIViewController, ViewModelApplyied, ViewControllerMakeable {
    var viewModel: ViewModel!
    var tableView: UITableView!
    var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Links"
//        addCloseButton()
        addTextField()
        addTableView()
        viewModel.start()
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
    @objc func didEndOnExit(sender: Any) {
        viewModel.save(url: textField.text ?? "no data") { [weak self] result in
            switch result {
            case .success(_):
                self?.viewModel.refreshData()
                self?.tableView.reloadData()
            case .failure(let error):
                print("Saving Error \(error)")
            }
        }
        textField.text = ""
    }
    private func addTextField() {
        textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Insert RSS Link"
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.addTarget(self, action: #selector(didEndOnExit), for: .editingDidEndOnExit)
        view.addSubview(textField)
        let constraints = [textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 85),
                           textField.heightAnchor.constraint(equalToConstant: 50),
                           textField.widthAnchor.constraint(equalToConstant: view.bounds.size.width-30),
                           textField.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    private func addTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)]
        NSLayoutConstraint.activate(constraints)
    }
}
// MARK: - TableView Delegate, DataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "default")
        cell.textLabel?.text = viewModel.cellViewModel(for: indexPath.row).url
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "New Items"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsNumber
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.deleteLink(for: indexPath.row)
        viewModel.refreshData()
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
