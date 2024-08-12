import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .foregroundColor(.white)
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    HeaderView()
                    CurrentWeatherView(city: viewModel.city, temperature: viewModel.forecasts.first?.main.temp ?? 0.0, description: viewModel.forecasts.first?.weather.first?.description ?? "")
                    ForecastView(forecasts: viewModel.forecasts)
                }
                Spacer()
            }
        }
        .onAppear {
            viewModel.getWeatherForecast()
        }
    }
}


#Preview {
    WeatherView()
}
