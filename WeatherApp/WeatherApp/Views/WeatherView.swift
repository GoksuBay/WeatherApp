import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HeaderView()
                CurrentWeatherView()
                    .padding(.bottom, 64)
                ForecastView()
                Spacer()
            }
        }
    }
}

#Preview {
    WeatherView()
}
