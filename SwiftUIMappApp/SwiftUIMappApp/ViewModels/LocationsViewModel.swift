//
//  LocationsViewModel.swift
//  SwiftUIMappApp
//
//  Created by MUTLUHAN BOZ on 15.07.2023.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    
    @Published var currentLocation: Location {
        didSet {
            withAnimation(.easeInOut) {
                mapRegion = generateCoordinateRegion(from: currentLocation)
            }
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion?
    
    @Published var showLocationList: Bool = false
    
    @Published var sheetLocation: Location? = nil
    
    let defaultMapSpan = MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075)
    let defaultSpanForDetail = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.currentLocation = locations.first!
        self.mapRegion = generateCoordinateRegion(from: currentLocation)
    }
    
    private func generateCoordinateRegion(from location: Location) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: currentLocation.coordinates, span: defaultMapSpan)
    }
    
    func setCurrentLocation(newLocation: Location) {
        self.currentLocation = newLocation
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func nextButtonAction() {
        guard let currentIndex = locations.firstIndex(of: currentLocation) else { return }
        let newSafeIndex = (currentIndex+1) % locations.count
        let nextLocation = locations[newSafeIndex]
        setCurrentLocation(newLocation: nextLocation)
    }
    
}
