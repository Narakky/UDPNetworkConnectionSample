//
//  BaseTableViewCell.swift
//  UDPNetworkConnectionSample
//
//  Created by Naraki on 8/9/19.
//  Copyright © 2019 i-enter. All rights reserved.
//

import UIKit

protocol BaseTableViewCellProtocol {
  func set(data: SettingsViewController.TableData)
}

class BaseTableViewCell: UITableViewCell, BaseTableViewCellProtocol {
  func set(data: SettingsViewController.TableData) {}
}
