//
//  LocationDetailView.swift
//  SwiftUIMappApp
//
//  Created by MUTLUHAN BOZ on 20.07.2023.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    let location: Location
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        ScrollView {
            VStack{
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x:0, y:10)
                
            }
            VStack(alignment: .leading, spacing: 16) {
                titleSection
                Divider()
                descriptionSection
                Divider()
                mapSection
            }
                
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topTrailing)
        
    }
}

extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 500)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let url = URL(string: location.link) {
                Link("Read More", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var mapSection: some View {
        
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: vm.defaultSpanForDetail)),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                MapAnnotationView()
            }
        }.allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(20)
            .padding()
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding()
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .padding()
        }

    }
    
    

}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}
