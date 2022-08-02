//
//  BluetoothTestViewModel.swift
//  BlueToothTest
//
//  Created by Ash Oldham on 27/07/2022.
//

import UIKit
import CoreBluetooth

protocol BluetoothView: UIViewController {
  func update()
}

class BluetoothTestManager: NSObject {
  
  weak var view: BluetoothView?
  var scannedDevices: [BluetoothDeviceModel] = []
  private var centralManager: CBCentralManager!
  
  init(view: BluetoothView) {
    self.view = view
  }
}

extension BluetoothTestManager: CBCentralManagerDelegate {
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    // checks state of Bluetooth on device. On/Off?
    if central.state == CBManagerState.poweredOn {
      print("Bluetooth is ON", central.state)
      central.scanForPeripherals(withServices: nil, options: nil)
    } else {
      print("Bluetooth is OFF")
    }
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    // Begins scanning on button click
    if let pname = peripheral.name {
      DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
        self.stopScanning()
      }
      print(pname)
      addDevicestoArray(device: pname)
    }
  }
      
  private func stopScanning() {
    centralManager?.stopScan()
  }
  
  func startScanning() {
    centralManager = CBCentralManager(delegate: self, queue: nil)
  }
  
  private func addDevicestoArray(device: String) {
    self.scannedDevices.append(BluetoothDeviceModel(name: device))
    self.view?.update()
  }
}
