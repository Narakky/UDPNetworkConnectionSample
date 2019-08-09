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

  // MARK: - Lifecycle

  override func prepareForReuse() {
    super.prepareForReuse()

    titleLabel.text = nil
    inputText.text = nil
  }

  // MARK: - BaseTableViewCellProtocol

  override func set(data: SettingsViewController.TableData) {
    titleLabel.text = data.title
    inputText.placeholder = data.placeholder
  }
}
