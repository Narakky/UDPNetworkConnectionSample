//
//  SettingsViewController.swift
//  UDPNetworkConnectionSample
//
//  Created by Naraki on 8/9/19.
//  Copyright © 2019 i-enter. All rights reserved.
//

import UIKit

protocol SettingsActionProtocol: AnyObject {
  func saveButtonTapped()
}

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

  // MARK: - Variables

  private lazy var ipAddress: String? = {
    return UserDefaultManager.shared.get(key: .ipAddress) as? String
  }()
  private lazy var portNumber: Int? = {
    return UserDefaultManager.shared.get(key: .port) as? Int
  }()

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
    cell.set(data: tableData, values: ipAddress, portNumber)
    if let controlsCell = cell as? SettingsControlsTableViewCell {
      controlsCell.delegate = self
    }
    return cell
  }
}

extension SettingsViewController: SettingsActionProtocol {
  func saveButtonTapped() {
    var isChanged: Bool = false

    if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SettingsInputTableViewCell {
      if let ipAddress = cell.ipAddress, !ipAddress.isEmpty {
        self.ipAddress = ipAddress
        UserDefaultManager.shared.set(key: .ipAddress, value: ipAddress)
        isChanged = true
      }
    }
    if let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? SettingsInputTableViewCell {
      if let portNumberString = cell.port, !portNumberString.isEmpty, let port = Int(portNumberString) {
        self.portNumber = port
        UserDefaultManager.shared.set(key: .port, value: port)
        isChanged = true
      }
    }

    if isChanged {
      let alert = UIAlertController(title: nil, message: "Saved.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
        self?.dismiss(animated: true, completion: nil)
      })
      present(alert, animated: true, completion: nil)
    }
  }
}
