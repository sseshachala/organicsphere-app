//
//  OSLocationManager.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-26.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import CoreLocation

class OSLocationManager: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    //MARK: Shared Instance
    
    static let sharedInstance : OSLocationManager = {
        let instance = OSLocationManager()
        return instance
    }()
    
    func intializeLocationManager() {
        manager.delegate = OSLocationManager.sharedInstance
        manager.desiredAccuracy = kCLLocationAccuracyBest
        checkIfLocationServicesAreEnables()
    }

    
    func checkIfLocationServicesAreEnables() {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                let alertController = UIAlertController(
                    title: "Location Access Disabled",
                    message: "In order to calculate tax and prefill location for delivery. Please set location access to 'WhenInUse'.",
                    preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                    if let url = URL(string:UIApplicationOpenSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                alertController.addAction(openAction)
                UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                startLocationUpdates()
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    private func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            startLocationUpdates()
            // ...
        }
    }
    
    func startLocationUpdates() {
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        for location in locations {
            
            print("**********************")
            print("Long \(location.coordinate.longitude)")
            print("Lati \(location.coordinate.latitude)")
            print("Alt \(location.altitude)")
            print("Sped \(location.speed)")
            print("Accu \(location.horizontalAccuracy)")
            
            print("**********************")
            
            
        }
        
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)-> Void in
            if error != nil {
                print("Reverse geocoder failed with error: \(error?.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?[0] {
                manager.stopUpdatingLocation()
                let postalCode = (placemark.postalCode != nil) ? placemark.postalCode : ""
                print("Postal code updated to: \(postalCode)")
            }else{
                print("No placemarks found.")
            }
        })
    }


}
