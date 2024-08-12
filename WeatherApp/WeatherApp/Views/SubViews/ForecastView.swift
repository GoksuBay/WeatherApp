//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import Foundation
import SwiftUI

struct ForecastView: View {
    var forecasts: [WeatherForecastResponse.Forecast]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("5 Day Forecast")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack {
                ForEach(forecasts.prefix(5), id: \.dt) { forecast in
                    Spacer()
                    VStack {
                        Text(forecast.dt_txt.toDayOfWeek().prefix(3))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Image(systemName: "cloud.sun.rain.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .yellow, .blue)
                        
                        Text("\(Int(forecast.main.temp))°")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}


#Preview {
    ForecastView(forecasts: [.init(dt: 10, main: .init(temp: 37.5, feels_like: 38, temp_min: 35, temp_max: 39, pressure: 10, sea_level: 5, grnd_level: 5, humidity: 50, temp_kf: 20), weather: [.init(id: 5, main: "Antalya", description: "Cloudy", icon: "no")], clouds: WeatherForecastResponse.Forecast.Clouds.init(all: 5), wind: .init(speed: 10, deg: 5, gust: 20), visibility: 1, pop: 2, sys: WeatherForecastResponse.Forecast.Sys.init(pod: ""), dt_txt: "rfdh")])
}
