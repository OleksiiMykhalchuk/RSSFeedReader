//
//  ListViewController.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/25/22.
//

import UIKit

class ListViewController: UIViewController, ViewModelApplyied, ViewControllerMakeable {
  var tableView: UITableView!
<<<<<<< HEAD:RSSFeedReader/Flows/List/View/ListViewController.swift
  var loadData = LoadData()
  var viewModel: ListViewModel?
=======
//  var loadData: LoadData?
  var viewModel: ViewModel!
>>>>>>> 3aff67e79552cab9f3f91df35c3a83ef124541af:RSSFeedReader/Flows/List/ListViewController.swift
    override func viewDidLoad() {
        super.viewDidLoad()
      title = "Title"
      showTableView()
<<<<<<< HEAD:RSSFeedReader/Flows/List/View/ListViewController.swift
      loadData.loadData()
=======
//      loadData = LoadData()
//      loadData?.loadData()
>>>>>>> 3aff67e79552cab9f3f91df35c3a83ef124541af:RSSFeedReader/Flows/List/ListViewController.swift
      let nib = UINib(nibName: "ListCell", bundle: nil)
      tableView.register(nib, forCellReuseIdentifier: "ListCell")
        viewModel.reloadData.bind(to: self) { _ in
            // refresh tableView
        }
        viewModel.start()
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
      let cellViewModel = viewModel.cellViewModel(for: indexPath.row)
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListTableViewCell
<<<<<<< HEAD:RSSFeedReader/Flows/List/View/ListViewController.swift
    cell?.titleLabel.text = "Text Cell"
    cell?.pubDateLabel.text = "PubDate"
    tableView.rowHeight = 80
=======
      cell?.viewModel = cellViewModel
    tableView.rowHeight = 99
>>>>>>> 3aff67e79552cab9f3f91df35c3a83ef124541af:RSSFeedReader/Flows/List/ListViewController.swift
    return cell!
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.itemNumber
  }
}
