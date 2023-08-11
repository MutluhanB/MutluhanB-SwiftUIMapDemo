//
//  LocationsView.swift
//  SwiftUIMappApp
//
//  Created by MUTLUHAN BOZ on 15.07.2023.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject private var vm: LocationsViewModel
        
    var body: some View {
        ZStack {
            mapView
                .ignoresSafeArea()

            VStack {
                header
                    .padding()
                Spacer()
                
                selectedLocationView
           
            }
        }.sheet(item: $vm.sheetLocation) { location in
            LocationDetailView(location: location)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    private var mapView: some View {
        Map(coordinateRegion: Binding($vm.mapRegion)!, annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                MapAnnotationView()
                    .scaleEffect(location == vm.currentLocation ? 0.9 : 0.6)
                    .onTapGesture {
                        vm.setCurrentLocation(newLocation: location)
                    }
            }
        })
    }
    private var header: some View {
        VStack {
            
            Button {
                vm.toggleLocationList()
            } label: {
                Text(vm.currentLocation.name + " " + vm.currentLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Image(systemName: vm.showLocationList ? "arrow.up" : "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                    }
            }
            if (vm.showLocationList) {
                LocationsListView()
            }
                
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.5 ), radius: 20)
    }
    
    private var selectedLocationView: some View {
        ZStack {
             ForEach(vm.locations) { location in
                if location == vm.currentLocation {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
        
                }
            }
        }
    }
}
