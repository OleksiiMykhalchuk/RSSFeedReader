//
//  ListViewController.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import UIKit

class ListViewController: UIViewController {
  var tableView: UITableView!
  var viewModel: ListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
      title = "Title"
      showTableView()
    }
  private func showTableView() {
    tableView = UITableView(frame: view.frame)
    tableView.dataSource = self
    view.addSubview(tableView)
  }
}
// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "ListCell")
    cell.textLabel?.text = "Text Cell"
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 30  }
}
