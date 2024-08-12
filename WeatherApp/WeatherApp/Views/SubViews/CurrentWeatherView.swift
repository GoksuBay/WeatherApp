//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import SwiftUI

struct CurrentWeatherView: View {
    var city: String
    var temperature: Double
    var description: String
    
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
                    
                    Text(city)
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
                Text("\(String(format: "%.1f", temperature))°")
                    .font(.system(size: 50))
                    .bold()
                    .foregroundColor(.white)
                
                Text(description.capitalized)
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
    CurrentWeatherView(city: "Antalya", temperature: 39.5, description: "Test")
}
