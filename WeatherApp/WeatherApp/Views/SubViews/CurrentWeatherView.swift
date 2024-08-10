//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import Foundation
import SwiftUI

struct CurrentWeatherView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Weather")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack {
                    Image(systemName: "location.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray)
                    
                    Text("Antalya")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Image(systemName: "cloud.sun.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .yellow)
            
            VStack(alignment: .trailing) {
                Text("24°")
                    .font(.system(size: 50))
                    .bold()
                    .foregroundColor(.white)
                
                Text("Mostly Clear")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

#Preview {
    CurrentWeatherView()
}
