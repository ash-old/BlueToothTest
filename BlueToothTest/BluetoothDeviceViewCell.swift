//
//  BluetoothDeviceViewCell.swift
//  BlueToothTest
//
//  Created by Ash Oldham on 26/07/2022.
//

import UIKit

final class BluetoothDeviceViewCell: UITableViewCell {
  
  let icon: UIImageView = {
    let icon = UIImageView()
    icon.tintColor = .black
    icon.contentMode = .scaleAspectFit
    return icon
  }()
  
  let deviceLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 17)
    return label
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [icon, deviceLabel])
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.setCustomSpacing(8, after: icon)
    return stackView
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
    backgroundColor = .clear
    selectionStyle = .none
    
    [icon, deviceLabel].forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      icon.heightAnchor.constraint(equalToConstant: 25),
      icon.widthAnchor.constraint(equalToConstant: 25),
      
      deviceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      deviceLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
      deviceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      deviceLabel.heightAnchor.constraint(equalToConstant: 25),
      
    ])
  }
}
