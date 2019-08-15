//
//  ConnectionLogTableViewCell.swift
//  UDPNetworkConnectionSample
//
//  Created by Naraki on 8/9/19.
//  Copyright © 2019 i-enter. All rights reserved.
//

import UIKit

final class ConnectionLogTableViewCell: UITableViewCell {
  // MARK: - Outlet

  @IBOutlet private weak var datetimeLabel: UILabel!
  @IBOutlet private weak var logTextLabel: UILabel!

  // MARK: - Lifecycle

  override func prepareForReuse() {
    super.prepareForReuse()
  }
}
