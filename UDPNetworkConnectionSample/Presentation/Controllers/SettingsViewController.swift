//
//  SettingsViewController.swift
//  UDPNetworkConnectionSample
//
//  Created by Naraki on 8/9/19.
//  Copyright © 2019 i-enter. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
  // MARK: - Definitions

  enum TableData: CaseIterable {
    case inputIPAddress
    case inputPort
    case controls

    var title: String {
      switch self {
      case .inputIPAddress: return "IP Address"
      case .inputPort: return "Port"
      case .controls: return "Controls"
      }
    }

    var placeholder: String? {
      switch self {
      case .inputIPAddress: return "IPアドレスを入力してください"
      case .inputPort: return "ポート番号を入力してください"
      default: return nil
      }
    }

    var cellIdentifier: String {
      switch self {
      case .inputIPAddress, .inputPort: return R.nib.settingsInputTableViewCell.name
      case .controls: return R.nib.settingsControlsTableViewCell.name
      }
    }

    static func get(indexPath: IndexPath) -> SettingsViewController.TableData {
      return allCases[indexPath.row]
    }
  }

  // MARK: - Outlet

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.dataSource = self
      tableView.separatorInset = .zero
      tableView.separatorStyle = .none
      tableView.tableFooterView = UIView()
      tableView.rowHeight = UITableView.automaticDimension
      tableView.estimatedRowHeight = 80
      tableView.allowsSelection = false
      tableView.register(UINib(resource: R.nib.settingsInputTableViewCell), forCellReuseIdentifier: R.nib.settingsInputTableViewCell.name)
      tableView.register(UINib(resource: R.nib.settingsControlsTableViewCell), forCellReuseIdentifier: R.nib.settingsControlsTableViewCell.name)
    }
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return TableData.allCases.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let tableData = TableData.get(indexPath: indexPath)
    guard let cell = tableView.dequeueReusableCell(withIdentifier: tableData.cellIdentifier) as? BaseTableViewCell else {
      return UITableViewCell()
    }
    cell.set(data: tableData)
    return cell
  }
}
