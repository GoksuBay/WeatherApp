//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var forecasts: [WeatherForecastResponse.Forecast] = []
    @Published var city: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false    
    @Published var currentLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    private let locationManager = LocationManager()
    
    private let weatherRepository: WeatherRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherRepository: WeatherRepositoryProtocol = WeatherRepository()) {
        self.weatherRepository = weatherRepository
    }
    
    private func getWeatherForecast(latitude: Double, longitude: Double) {
        isLoading = true
        weatherRepository.getWeatherForecast(for: latitude, longitude: longitude) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.processForecastData(forecasts: response.list)
                    self?.city = response.city.name
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch weather data: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func getWeatherForecast() {
        locationManager.$location
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                guard let self = self, let location = location else { return }
                self.currentLocation = location
                self.getWeatherForecast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
            .store(in: &cancellables)
        
        locationManager.$authorizationStatus
            .receive(on: DispatchQueue.main)
            .assign(to: \.authorizationStatus, on: self)
            .store(in: &cancellables)
        
        locationManager.requestLocation()
    }
    
    private func processForecastData(forecasts: [WeatherForecastResponse.Forecast]) {
        // Tarihe göre gruplama ve ilk değeri alma
        let uniqueDayForecasts = Dictionary(grouping: forecasts, by: { forecast in
            String(forecast.dt_txt.prefix(10)) // Sadece tarihi alıyoruz (YYYY-MM-DD)
        }).compactMap { $0.value.first } // Her grup için ilk değeri alıyoruz
        
        // UI'da göstermek için sıralama (isteğe bağlı)
        self.forecasts = uniqueDayForecasts.sorted(by: { $0.dt_txt < $1.dt_txt })
    }
}
