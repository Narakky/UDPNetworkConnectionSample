//
//  ConnectionTestViewController.swift
//  UDPNetworkConnectionSample
//
//  Created by Naraki on 8/9/19.
//  Copyright © 2019 i-enter. All rights reserved.
//

import UIKit

final class ConnectionTestViewController: UIViewController {
  // MARK: - Definitions

  private enum Status {
    case success
    case error
    case connecting
    case disconnect

    var text: String {
      switch self {
      case .success: return "Success"
      case .error: return "Error"
      case .connecting: return "Connecting..."
      case .disconnect: return "Disconnect"
      }
    }

    var backgroundColor: UIColor {
      switch self {
      case .success: return UIColor(hex: "34C759")
      case .error: return UIColor(hex: "FF2600")
      case .connecting, .disconnect: return .lightGray
      }
    }

    var textColor: UIColor {
      switch self {
      case .success, .error: return .white
      case .connecting, .disconnect: return .darkGray
      }
    }
  }

  // MARK: - Outlet

  @IBOutlet private weak var statusLabel: UILabel! {
    didSet {
      changeStatus(status: .disconnect)
    }
  }
  @IBOutlet private weak var ipAddressLabel: UILabel! {
    didSet {
      setIPAddressLabel()
    }
  }
  @IBOutlet private weak var portNumberLabel: UILabel! {
    didSet {
      setPortNumberLabel()
    }
  }
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

  // MARK: - Constants

  private var hostname: String?
  private var portNumber: Int?
  private var server: EchoServerService?

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    // Hostname, Port, Serverの初期化
    hostname = UserDefaultManager.shared.get(key: .ipAddress) as? String
    setIPAddressLabel()

    portNumber = UserDefaultManager.shared.get(key: .port) as? Int
    if let portNumber = portNumber {
      self.portNumber = portNumber
      setPortNumberLabel()
      server = EchoServerService(port: portNumber)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    server?.run()
    print("Swift Echo Server Sample")
    print("Connect with a command line window by entering 'telnet ::1 \(String(describing: portNumber))'")
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    server?.shutdownServer()
  }
}

// MARK: - Private

private extension ConnectionTestViewController {
  func setIPAddressLabel() {
    let itemName = "IP Address:"
    if let hostname = hostname {
      ipAddressLabel.text = "\(itemName) \(hostname)"
    } else {
      ipAddressLabel.text = "\(itemName) -"
    }
  }

  func setPortNumberLabel() {
    let itemName = "Port:"
    if let portNumber = portNumber {
      portNumberLabel.text = "\(itemName) \(portNumber)"
    } else {
      portNumberLabel.text = "\(itemName) -"
    }
  }

  private func changeStatus(status: Status) {
    statusLabel.text = status.text
    statusLabel.textColor = status.textColor
    statusLabel.backgroundColor = status.backgroundColor
  }
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
