//
//  ViewController.swift
//  BlueToothTest
//
//  Created by Ash Oldham on 06/07/2022.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    centralManager = CBCentralManager(delegate: self, queue: nil)
    
    view.backgroundColor = .systemPink
  }
  
  var centralManager: CBCentralManager!
  var myPeripheral: CBPeripheral!

}

extension ViewController: CBCentralManagerDelegate, CBPeripheralDelegate {
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
    }
  }
  
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    self.myPeripheral.discoverServices(nil)
  }
  
  
}

