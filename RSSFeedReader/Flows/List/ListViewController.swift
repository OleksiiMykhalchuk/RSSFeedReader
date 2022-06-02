//
//  ListViewController.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import UIKit

class ListViewController: UIViewController, ViewModelApplyied, ViewControllerMakeable {
    var tableView: UITableView!
    var viewModel: ViewModel!
    var status: NetworkManager.Status!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        showTableView()
        let nib = UINib(nibName: "ListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ListCell")
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "LoadingCell")
        viewModel.reloadData.bind(to: self) { [weak self] _ in
            // refresh tableView
            self?.tableView.reloadData()
        }
        viewModel.start()
        addBarButton()
        NotificationCenter.default.addObserver(forName: Notification.Name("Name"), object: nil, queue: .main, using: { [weak self] note in
            let alert = UIAlertController(title: "Error", message: "\(note.object)", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil )
            alert.addAction(action)
            self?.tableView.reloadData()
            self?.present(alert, animated: true)
        })
    }
    private func showTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    private func addBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(update))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settings))
    }
    @objc func update(sender: Any) {
        print("Update")
        viewModel.start()
        viewModel.reloadData.bind(to: self, callback: { [weak self] _ in
            self?.tableView.reloadData()
        })
    }
    @objc func settings(sender: Any) {
    }
}
// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.isLoading() {
        case .loading:
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell")
            let spinner = loadingCell?.viewWithTag(100) as? UIActivityIndicatorView
            spinner?.startAnimating()
            tableView.rowHeight = 44
            return loadingCell!
        case .loaded:
            let cellViewModel = viewModel.cellViewModel(for: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListTableViewCell
            // if new show green
            if viewModel.cellViewIfNew(for: indexPath.row) {
                cell?.backgroundColor = .green
            }
            cell?.viewModel = cellViewModel
            cell?.layer.borderWidth = 1
            tableView.rowHeight = 160
            return cell!
        case .error:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.isLoading() {
        case .loading:
            return 1
        case .loaded:
            return viewModel.itemNumber
        case .error:
            return 0
        }
    }
}
// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.cellViewModel(for: indexPath.row)
        viewModel.coordinator?.goToDetailsPage(with: data)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
