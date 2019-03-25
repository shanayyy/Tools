//
//  LocationUpdater.swift
//  Pods
//
//  Created by 杨俊江 on 2019/3/19.
//

import Foundation
import CoreLocation

public class LocationUpdater: NSObject, CLLocationManagerDelegate {
    private var lm: CLLocationManager
    
    private(set) lazy var events: Events = .init()
    
    public init(locationManager: CLLocationManager) {
        lm = locationManager
        super.init()
        lm.delegate = self
    }
    
    convenience public init(activityType: CLActivityType, distanceFilter: CLLocationDistance, desiredAccuracy: CLLocationAccuracy) {
        let lm = CLLocationManager()
        lm.activityType = activityType
        lm.distanceFilter = distanceFilter
        lm.desiredAccuracy = desiredAccuracy
        self.init(locationManager: lm)
    }
    
    public func startUpdating() {
        lm.startUpdatingLocation()
        events.didUpdateHeading.publish(CLHeading())
    }
    
    public func stopUpdating() {
        lm.stopUpdatingLocation()
    }
}

// 事件订阅
extension LocationUpdater {
    public class Events {
        lazy var didUpdateLocations = Subscribeable<CLLocation>()
        lazy var didUpdateLocationsError = Subscribeable<Error>()
        lazy var didUpdateHeading = Subscribeable<CLHeading>()
        lazy var didUpdateHeadingError = Subscribeable<Error>()
    }
}




let lu = LocationUpdater(locationManager: CLLocationManager())
let ob = lu.events.didUpdateLocations.publish(CLLocation())
