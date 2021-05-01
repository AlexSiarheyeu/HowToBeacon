//
//  BeaconTableViewCell.swift
//  HowToBeacon
//
//  Created by Alexey Sergeev on 1/28/21.
//  Copyright © 2021 Alexey Sergeev. All rights reserved.
//

import UIKit
import CoreLocation


class BeaconTableViewCell: UITableViewCell {
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ beaconsArray: [CLBeacon]?, in indexPath: IndexPath) {
        
        if let parsedBeaconsArray = beaconsArray?[indexPath.row] {
           uuidLabel.text = "Proximity UUID: \(parsedBeaconsArray.proximityUUID)"
           majorLabel.text = "Major: \(parsedBeaconsArray.major)"
           minorLabel.text = "Minor: \(parsedBeaconsArray.minor)"
           rssiLabel.text = "RSSI: \(parsedBeaconsArray.rssi)"
       }
    }
    
    func changeColor() {
        contentView.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 127/255, alpha: 1.0)
    }
}
