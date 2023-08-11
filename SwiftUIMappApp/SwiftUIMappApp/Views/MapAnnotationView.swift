//
//  MapAnnotationView.swift
//  SwiftUIMappApp
//
//  Created by MUTLUHAN BOZ on 18.07.2023.
//

import SwiftUI

struct MapAnnotationView: View {
    var body: some View {
        VStack {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(6)
                .background(.red)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -8)
                .foregroundColor(.red)
        }.offset(y: -20)
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        
        MapAnnotationView().border(.blue)
    }
}
