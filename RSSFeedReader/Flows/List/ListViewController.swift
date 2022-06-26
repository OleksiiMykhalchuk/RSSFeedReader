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
    private var isNotScrolled: Bool!
    private let refreshControll = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        isNotScrolled = true
        showTableView()
        tableView.register(R.nib.listCell)
        tableView.register(R.nib.loadingCell)
        viewModel.reloadData.bind(to: self) { [weak self] _ in
            // refresh tableView
            self?.tableView.reloadData()
        }
        viewModel.updateStatusData.bind(to: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        viewModel.start()
        addBarButton()
        viewModel.saveOldViewDate()
    }
    private func showTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControll
        } else {
            tableView.addSubview(refreshControll)
        }
    }
    private func addBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Refresh", style: .plain, target: self, action: #selector(update))
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "URLs", style: .plain, target: self, action: #selector(settings))
    }
    @objc private func update() {
        print("Update")
//        refreshControll.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        viewModel.saveOldViewDate()
        viewModel.startUpdate()
        viewModel.reloadData.bind(to: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        isNotScrolled = true
    }
    @objc private func refreshData(_ sender: Any) {

        print("****RefreshData")
    }
    @objc func settings(sender: Any) {
        viewModel.coordinator?.goToSettingsPage()
    }
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.updateStatusData.lastValue == .inProgress {
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell")
            let spinner = loadingCell?.viewWithTag(100) as? UIActivityIndicatorView
            spinner?.startAnimating()
            return loadingCell!
        } else if viewModel.updateStatusData.lastValue == .finish {
                let cellViewModel = viewModel.cellViewModel(for: indexPath.row)
                let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListTableViewCell
                if viewModel.cellViewIfNew(for: indexPath.row) {
                    cell?.backgroundColor = .green
                } else {
                    cell?.backgroundColor = .white
                }
                cell?.viewModel = cellViewModel
                cell?.layer.borderWidth = 1
                return cell!
        } else if viewModel.updateStatusData.lastValue == .noLinks {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Failure No Links")
            cell.textLabel?.text = "Error Add Link"
            cell.textLabel?.textAlignment = .center
            showAlert(title: "No Links", message: "Add Link")
            NSLog("Error Loading")
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Failure")
            cell.textLabel?.text = "Error Loading"
            cell.textLabel?.textAlignment = .center
            showAlert(title: "Error Loading", message: "Check Internet Connection or URL!")
            NSLog("Error Loading")
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.updateStatusData.lastValue == .inProgress {
            return 1
        } else if viewModel.updateStatusData.lastValue == .finish {
            return viewModel.itemsNumber
        } else {
            return 1
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIdexPath = tableView.indexPathsForVisibleRows?.last,
           viewModel.updateStatusData.lastValue == .finish {
            if indexPath == lastVisibleIdexPath, isNotScrolled {
                viewModel.saveLastViewDate()
                isNotScrolled = false
                let errorCollection = viewModel.ifUrlFailed()
                if !errorCollection.isEmpty {
                    var url = ""
                    var message = ""
                    for index in 0..<viewModel.ifUrlFailed().count {
                        url += "\(index+1). [\(errorCollection[index].url)]\n"
                        message += "\(index+1). Error Message: \(errorCollection[index].fetchedError.localizedDescription)\n"
                    }
                    showAlert(title: url, message: message)
                }
            }
        }
    }
}
