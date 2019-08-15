//
//  SettingsInputTableViewCell.swift
//  UDPNetworkConnectionSample
//
//  Created by Naraki on 8/9/19.
//  Copyright © 2019 i-enter. All rights reserved.
//

import UIKit

final class SettingsInputTableViewCell: BaseTableViewCell {

  // MARK: - Outlet

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var inputText: UITextField!

  // MARK: - Variables

  private var tableData: SettingsViewController.TableData?

  var ipAddress: String? {
    if let data = tableData, data == .inputIPAddress {
      return inputText.text
    }
    return nil
  }

  var port: String? {
    if let data = tableData, data == .inputPort {
      return inputText.text
    }
    return nil
  }

  // MARK: - Lifecycle

  override func prepareForReuse() {
    super.prepareForReuse()

    titleLabel.text = nil
    inputText.text = nil
  }

  // MARK: - BaseTableViewCellProtocol

  override func set(data: SettingsViewController.TableData, values: Any?...) {
    tableData = data
    titleLabel.text = data.title
    inputText.placeholder = data.placeholder

    if values.count >= 2 {
      if data == .inputIPAddress, let ipAddress = values[0] as? String {
        inputText.text = ipAddress
      }
      if data == .inputPort, let port = values[1] as? Int {
        inputText.text = "\(port)"
      }
    }
  }
}
