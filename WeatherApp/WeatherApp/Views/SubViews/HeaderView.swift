//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Morning! ")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.leading, 16)
            
            HStack {
                Text("Thu, Apr 25 - 06:32 PM")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 16)
        }
        .padding(.top, 40)
        .padding(.horizontal)
    }
}


#Preview {
    HeaderView()
        .colorInvert()
}
