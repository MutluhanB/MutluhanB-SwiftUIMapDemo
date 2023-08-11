                 //
//  SwiftUIMappAppApp.swift
//  SwiftUIMappApp
//
//  Created by MUTLUHAN BOZ on 14.07.2023.
//

import SwiftUI
 
@main
struct SwiftUIMappAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
