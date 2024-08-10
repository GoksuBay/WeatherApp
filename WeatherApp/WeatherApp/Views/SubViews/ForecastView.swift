//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import Foundation
import SwiftUI

struct ForecastView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Forecast")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack {
                ForEach(0..<7) { _ in
                    Spacer()
                    VStack {
                        Text("Wed")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Image(systemName: "cloud.sun.rain.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .yellow, .blue)
                        
                        Text("10°")
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
    ForecastView()
}
