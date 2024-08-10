//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var forecasts: [WeatherForecastResponse.Forecast] = []
    @Published var city: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    private let weatherRepository: WeatherRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherRepository: WeatherRepositoryProtocol = WeatherRepository()) {
        self.weatherRepository = weatherRepository
    }
    
    func getWeatherForecast(latitude: Double, longitude: Double) {
        isLoading = true
        weatherRepository.getWeatherForecast(for: latitude, longitude: longitude) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.forecasts = response.list
                    self?.city = response.city.name
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch weather data: \(error.localizedDescription)"
                }
            }
        }
    }
}
