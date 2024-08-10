//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import Foundation

protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension APIEndpoint {
    var urlComponents: URLComponents? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryItems
        return components
    }
    
    var request: URLRequest? {
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
}

struct WeatherAPI: APIEndpoint {
    let latitude: Double
    let longitude: Double
    
    var baseURL: String {
        "https://api.openweathermap.org/data/2.5"
    }
    
    var path: String {
        "/forecast"
    }
    
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "appid", value: "88d86cb0705ac473fe3ff1f8b8e01396"),
            URLQueryItem(name: "units", value: "metric")
        ]
    }
}

