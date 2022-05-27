//
//  ListViewController.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import UIKit

class ListViewController: UIViewController {
  var tableView: UITableView!
  var loadData: LoadData?
  var viewModel: ListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
      title = "Title"
      showTableView()
      loadData = LoadData()
      loadData?.loadData()
      let nib = UINib(nibName: "ListCell", bundle: nil)
      tableView.register(nib, forCellReuseIdentifier: "ListCell")
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListTableViewCell
    cell?.titleLabel.text = "Text Cell"
    cell?.pubDateLabel.text = "PubDate"
    tableView.rowHeight = 99
    return cell!
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
}
