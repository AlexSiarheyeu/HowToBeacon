//
//  ViewController.swift
//  HowToBeacon
//
//  Created by Alexey Sergeev on 1/28/21.
//  Copyright © 2021 Alexey Sergeev. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {
    
    private var cell: BeaconTableViewCell!
    private var manager: LocationAndBeaconManager!
    private var beaconsArray: [CLBeacon]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = LocationAndBeaconManager()
        manager.delegate = self
        
        tableView.register(UINib(nibName: "BeaconTableViewCell", bundle: nil), forCellReuseIdentifier: "beaconCellId")
        tableView.rowHeight = 100
        
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  beaconsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "beaconCellId") as? BeaconTableViewCell
        if indexPath.row == 0 {
            cell.changeColor()
        }
        cell.configure(beaconsArray, in: indexPath)
        return cell
    }
}

extension ViewController: BeaconDelegate {
    
    var beacons: [CLBeacon]? {
        get {
            return beaconsArray
        }
        set {
            beaconsArray = newValue
        }
    }
}
