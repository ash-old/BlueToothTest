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

class BluetoothTestViewModel: NSObject {
  
  var view: BluetoothView?
  var scannedDevices: [DeviceModel] = []
  var centralManager: CBCentralManager!
  var myPeripheral: CBPeripheral!
  
  init(view: BluetoothView, scannedDevices: [DeviceModel]) {
    self.view = view
    self.scannedDevices = scannedDevices
  }
  
  override init() {
    super.init()
    centralManager = CBCentralManager(delegate: self, queue: nil)
  }
}

extension BluetoothTestViewModel: CBCentralManagerDelegate, CBPeripheralDelegate {
  
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
    if let pname = peripheral.name {
      if pname == "SHIELD" {
        central.stopScan()
        
        self.myPeripheral = peripheral
        myPeripheral.delegate = self
        
        central.connect(peripheral, options: nil)
      }
      print(pname)
      addDevicestoArray(device: peripheral.name ?? "No Device name")
    }
  }
  
  func addDevicestoArray(device: String) {
    self.scannedDevices.append(DeviceModel(name: device))
    print("READ", scannedDevices)
    self.view?.update()
  }
                               
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    self.myPeripheral.discoverServices(nil)
  }
}
