//
//  ConnectionTestViewController.swift
//  UDPNetworkConnectionSample
//
//  Created by Naraki on 8/9/19.
//  Copyright © 2019 i-enter. All rights reserved.
//

import UIKit

final class ConnectionTestViewController: UIViewController {
  // MARK: - Outlet

  @IBOutlet private weak var statusLabel: UILabel!
  @IBOutlet private weak var ipAddressLabel: UILabel!
  @IBOutlet private weak var portNumberLabel: UILabel!
  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.dataSource = self
      tableView.separatorInset = .zero
      tableView.separatorColor = .lightGray
      tableView.tableFooterView = UIView()
      tableView.rowHeight = UITableView.automaticDimension
      tableView.estimatedRowHeight = 80
      tableView.register(UINib(resource: R.nib.connectionLogTableViewCell), forCellReuseIdentifier: R.nib.connectionLogTableViewCell.name)
    }
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Action

}

// MARK: - UITableViewDataSource

extension ConnectionTestViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.connectionLogTableViewCell.name) else { return UITableViewCell() }
    return cell
  }
}
