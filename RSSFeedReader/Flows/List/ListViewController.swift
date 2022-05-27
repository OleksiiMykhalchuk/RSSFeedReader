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
      let cellViewModel = viewModel.cellViewModel(for: indexPath.row)
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListTableViewCell
      cell?.viewModel = cellViewModel
    return cell!
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.itemNumber
  }
}
// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.coordinator?.goToDetailsPage(with: viewModel.didSelectItem(with: indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
