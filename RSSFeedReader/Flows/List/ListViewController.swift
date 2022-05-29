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
    }
    private func showTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
}
// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.isLoding() {
        case .loading:
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell")
            let spinner = loadingCell?.viewWithTag(100) as? UIActivityIndicatorView
            spinner?.startAnimating()
            tableView.rowHeight = 44
            return loadingCell!
        case .loaded:
            let cellViewModel = viewModel.cellViewModel(for: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListTableViewCell
            cell?.viewModel = cellViewModel
            tableView.rowHeight = 160
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.isLoding() {
        case .loading:
            return 1
        case .loaded:
            return viewModel.itemNumber
        }
    }
}
// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.coordinator?.goToDetailsPage(with: viewModel.didSelectItem(with: indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
