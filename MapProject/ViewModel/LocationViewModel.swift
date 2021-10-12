//
//  LocationViewModel.swift
//  MapProject
//
//  Created by user on 12.10.2021.
//

import SwiftUI
import CoreLocation
import MapKit

class LocationViewModel: NSObject, CLLocationManagerDelegate, MKMapViewDelegate, ObservableObject{
    @Published var location: CLLocation? = nil
    @Published var longitude = ""
    @Published var latitude = ""
    private var locationManager = CLLocationManager()
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.headingFilter = kCLHeadingFilterNone
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        getCoordinates()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
    }
    
    func getCoordinates(){
        self.latitude = String(locationManager.location?.coordinate.latitude ?? 0)
        self.longitude = String(locationManager.location?.coordinate.longitude ?? 0)
    }
}
