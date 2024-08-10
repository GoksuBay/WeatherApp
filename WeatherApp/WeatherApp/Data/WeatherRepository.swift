//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func getWeatherForecast(for latitude: Double, longitude: Double, completion: @escaping (Result<WeatherForecastResponse, NetworkError>) -> Void)
}

class WeatherRepository: WeatherRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getWeatherForecast(for latitude: Double, longitude: Double, completion: @escaping (Result<WeatherForecastResponse, NetworkError>) -> Void) {
            let forecastAPI = WeatherAPI(latitude: latitude, longitude: longitude)
            networkService.request(endpoint: forecastAPI) { (result: Result<WeatherForecastResponse, Error>) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                    
                case .failure(let error):
                    if let networkError = error as? NetworkError {
                        completion(.failure(networkError))
                    } else {
                        completion(.failure(.customError(message: error.localizedDescription)))
                    }
                }
            }
        }
}
