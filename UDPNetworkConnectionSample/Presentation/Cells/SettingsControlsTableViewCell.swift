//
//  SettingsControlsTableViewCell.swift
//  UDPNetworkConnectionSample
//
//  Created by Naraki on 8/9/19.
//  Copyright © 2019 i-enter. All rights reserved.
//

import UIKit

final class SettingsControlsTableViewCell: BaseTableViewCell {
  // MARK: - Outlet

  @IBOutlet private weak var saveButton: UIButton!

  // MARK: - Variables

  weak var delegate: SettingsActionProtocol?

  // MARK: - Action

  /// 保存ボタンタップ時
  ///
  /// - Parameter sender: UIButton
  @IBAction private func saveButtonTapped(_ sender: UIButton) {
    delegate?.saveButtonTapped()
  }

  // MARK: - BaseTableViewCellProtocol

  override func set(data: SettingsViewController.TableData, values: Any?...) {}
}

