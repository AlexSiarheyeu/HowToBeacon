//
//  LocationAndBeaconManager.swift
//  HowToBeacon
//
//  Created by Alexey Sergeev on 1/28/21.
//  Copyright © 2021 Alexey Sergeev. All rights reserved.
//

import UIKit
import CoreLocation


protocol BeaconDelegate: class {
    var beacons: [CLBeacon]? {get set}
}

class LocationAndBeaconManager: NSObject {
    
    private var locationManager: CLLocationManager!
    weak var delegate: BeaconDelegate!
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func startScanning() {
        
        let uuid = UUID(uuidString: "F0E53586-A680-42C9-9372-135429BC2E57")!
        let beaconID = "MyBeacon"
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: beaconID)
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
        
    }
    
    private func update(_ distance: CLProximity) {
        
        switch distance {
         
        case .immediate:
            print("immediate")
        case .near:
            print("near")
        default:
            print("default")
        }
    }

}

extension LocationAndBeaconManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        delegate.beacons = beacons

        if beacons.count > 0 {
            let nearestBeacon = beacons.first
//           let major = nearestBeacon?.major
//           let minor = nearestBeacon?.minor
            
            switch nearestBeacon?.proximity {
            
            case .immediate:
                update(.immediate)
            case .near:
                update(.near)
            case .far:
                update(.far)
            default:
                update(.unknown)
            }
        }
    }
}
