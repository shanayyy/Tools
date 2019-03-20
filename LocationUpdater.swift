//
//  LocationUpdater.swift
//  Pods
//
//  Created by 杨俊江 on 2019/3/19.
//

import Foundation
import CoreLocation

public class LocationUpdater: NSObject, CLLocationManagerDelegate {
    /// singleton
    public static let shared = LocationUpdater()
    
    private var lm = CLLocationManager.init()
    
    private override init() {
        super.init()
        lm.delegate = self
    }
    
    
    private(set) var rencentLocations = [CLLocation]()
    
    public func startUpdating() {
        lm.startUpdatingLocation()
    }
    
    public func stopUpdating() {
        lm.stopUpdatingLocation()
    }
}
