//
//  MethodChannelTest.swift
//  Runner
//
//  Created by Minh Hoàng Nguyễn Viết  on 08/06/2022.
//
//
//import Foundation
//import CoreLocation
//
//struct MethodChannelTest: CLLocationManagerDelegate{
//    var locationDescription: String?
//
//    let locationManager = CLLocationManager()
//    init() {
//        locationManager.delegate = self
//    }
//
//    mutating func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            locationManager.stopUpdatingLocation()
//
//            let lat = location.coordinate.latitude
//            let long = location.coordinate.longitude
//            self.locationDescription = "\(lat) and \(long)"
//        }
//    }
//
//    mutating func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        self.locationDescription = String(error.localizedDescription)
//
//    }
//}
