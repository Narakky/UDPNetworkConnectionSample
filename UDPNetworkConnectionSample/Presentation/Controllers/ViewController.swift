//
//  ViewController.swift
//  UDPNetworkConnectionSample
//
//  Created by Naraki on 8/8/19.
//  Copyright © 2019 i-enter. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

  // MARK: - Definitions

  private enum TableData: CaseIterable {
    case connectionTest
    case settings

    var title: String {
      switch self {
      case .connectionTest: return "接続テスト"
      case .settings: return "設定"
      }
    }

    var detail: String {
      switch self {
      case .connectionTest: return "UDP通信の接続テストを行います"
      case .settings: return "接続先の設定などを行います"
      }
    }

    static func get(indexPath: IndexPath) -> TableData {
      return allCases[indexPath.row]
    }
  }

  // MARK: - Outlet

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.tableFooterView = UIView()
      tableView.separatorInset = .zero
    }
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if let selectedIndexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: selectedIndexPath, animated: false)
    }
  }

}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return TableData.allCases.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
    let tableData = TableData.get(indexPath: indexPath)
    cell.textLabel?.text = tableData.title
    cell.detailTextLabel?.text = tableData.detail
    return cell
  }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let tableData = TableData.get(indexPath: indexPath)
    switch tableData {
    case .connectionTest:
      if let viewController = R.storyboard.connectionTestViewController().instantiateInitialViewController() {
        navigationController?.pushViewController(viewController, animated: true)
      }
    case .settings:
      if let viewController = R.storyboard.settingsViewController().instantiateInitialViewController() {
        navigationController?.pushViewController(viewController, animated: true)
      }
    }
  }
}
