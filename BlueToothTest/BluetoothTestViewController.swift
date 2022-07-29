//
//  BluetoothTestViewController.swift
//  BlueToothTest
//
//  Created by Ash Oldham on 06/07/2022.
//

import UIKit
import CoreBluetooth

class BluetoothTestViewController: UIViewController {

  var bluetoothManager: BluetoothTestManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bluetoothManager = BluetoothTestManager(view: self)
    view.backgroundColor = .lightGray
    setupViews()
  }
  
  let settingsLabel: UILabel = {
    let label = UILabel()
    label.text = "Devices"
    label.textAlignment = .center
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.boldSystemFont(ofSize: 34)
    return label
  }()
  
  private lazy var scanButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("SCAN", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .lightGray
    button.layer.cornerRadius = 4
    button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    button.layer.borderWidth = 1
    button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    button.layer.shadowRadius = 2.0
    button.layer.shadowOpacity = 1.0
    button.layer.masksToBounds = false
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    button.addTarget(self, action: #selector(onScanButtonTap), for: .touchUpInside)
    return button
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.separatorColor = .darkGray
    tableView.separatorInset = .zero
    tableView.isScrollEnabled = true
    tableView.showsVerticalScrollIndicator = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(BluetoothDeviceViewCell.self, forCellReuseIdentifier: "DeviceCell")
    return tableView
  }()
  
  @objc private func onScanButtonTap() {
    bluetoothManager.startScanning()
  }
  
  private func setupViews() {
    [settingsLabel, tableView, scanButton].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    NSLayoutConstraint.activate([
      settingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      settingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      tableView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 16),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      tableView.bottomAnchor.constraint(equalTo: scanButton.topAnchor, constant: -16),
      
      scanButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
      scanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      scanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
    ])
  }

}

// MARK: TableView
extension BluetoothTestViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bluetoothManager.scannedDevices.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as? BluetoothDeviceViewCell else { return UITableViewCell() }
    
    if indexPath.row > bluetoothManager.scannedDevices.count - 1 {
      tableView.reloadData()
      return UITableViewCell()
    } else {
      cell.deviceLabel.text = self.bluetoothManager.scannedDevices[indexPath.row].name
      cell.icon.image = UIImage(systemName: "wave.3.right.circle")
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
}

// MARK: Update TableView
extension BluetoothTestViewController: BluetoothView {
  func update() {
    tableView.reloadData()
  }
}
