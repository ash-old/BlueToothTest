//
//  ViewController.swift
//  BlueToothTest
//
//  Created by Ash Oldham on 06/07/2022.
//

import UIKit
import CoreBluetooth

class BluetoothTestViewController: UIViewController {

  var bluetoothManager: BluetoothTestManager!
  var viewModel: BluetoothTestManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
//    centralManager = CBCentralManager(delegate: self, queue: nil)
    bluetoothManager = BluetoothTestManager()
    view.backgroundColor = .lightGray
    setupViews()
  }
  
//  var centralManager: CBCentralManager!
//  var myPeripheral: CBPeripheral!
  
  let settingsLabel: UILabel = {
    let label = UILabel()
    label.text = "Settings"
    label.textAlignment = .left
    label.textColor = .black
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .title1), size: 32)
    return label
  }()
  
  private lazy var scanButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("SCAN", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemPink
    button.layer.cornerRadius = 4
    button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    button.layer.borderWidth = 1
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    button.addTarget(self, action: #selector(onScanButtonTap), for: .touchUpInside)
    return button
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.separatorColor = .clear
    tableView.isScrollEnabled = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(BluetoothDeviceViewCell.self, forCellReuseIdentifier: "DeviceCell")
    return tableView
  }()
  
  @objc private func onScanButtonTap() {
    print("clicked")
  }
  
  private func setupViews() {
    [settingsLabel, scanButton, tableView].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    NSLayoutConstraint.activate([
      settingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      settingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      
      scanButton.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 16),
      scanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      scanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      
      tableView.topAnchor.constraint(equalTo: scanButton.bottomAnchor, constant: 16),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
    ])
  }

}

// MARK: TableView
extension BluetoothTestViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("NUMBER", bluetoothManager.scannedDevices.count)
    return bluetoothManager.scannedDevices.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as? BluetoothDeviceViewCell else { return UITableViewCell() }
    
    cell.deviceLabel.text = bluetoothManager.scannedDevices[indexPath.row].name
    
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

// MARK: CB Delegate
//extension ViewController: CBCentralManagerDelegate, CBPeripheralDelegate {
//  func centralManagerDidUpdateState(_ central: CBCentralManager) {
//    // checks state of Bluetooth on device. On/Off?
//    if central.state == CBManagerState.poweredOn {
//      print("Bluetooth is ON", central.state)
//      
//      central.scanForPeripherals(withServices: nil, options: nil)
//    } else {
//      print("Bluetooth is OFF")
//    }
//  }
//  
//  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//    if let pname = peripheral.name {
//      if pname == "SHIELD" {
//        central.stopScan()
//        
//        self.myPeripheral = peripheral
//        myPeripheral.delegate = self
//        
//        central.connect(peripheral, options: nil)
//      }
//      print(pname)
//      viewModel?.scannedDevices.append(pname)
//    }
//  }
//  
//  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//    self.myPeripheral.discoverServices(nil)
//  }
//  
//  
//}

