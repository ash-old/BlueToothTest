//
//  BluetoothDeviceViewCell.swift
//  BlueToothTest
//
//  Created by Ash Oldham on 26/07/2022.
//

import UIKit

final class BluetoothDeviceViewCell: UITableViewCell {
  
  let deviceLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.text = "TEST"
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .title1), size: 17)
    return label
  }()
  
  static var reuseIdentifier = "DeviceCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    cellSetupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func cellSetupLayout() {
    backgroundColor = .blue
    selectionStyle = .none
    
    [deviceLabel].forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      deviceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      deviceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      deviceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      deviceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
}
