//
//  DiscoverView.swift
//  TravelDiscoveryLBTA
//
//  Created by Nurtugan Nuraly on 6/13/21.
//

// cmd + option + p

import SwiftUI

extension Color {
    static let discoverBackground = Color(white: 0.95, opacity: 1)
}

struct DiscoverView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9764705882, green: 0.7098039216, blue: 0.2705882353, alpha: 1)), Color(#colorLiteral(red: 0.9686769843, green: 0.5573006272, blue: 0.2894451618, alpha: 1))]), startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
                Color.discoverBackground
                    .offset(y: 400)
                ScrollView {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Where do you want to go?")
                        Spacer()
                    }.font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(white: 1, opacity: 0.3))
                    .cornerRadius(10)
                    .padding(16)
                    DiscoverCategoriesView()
                    VStack {
                        PopularDestinationsView()
                        PopularRestaurantsView()
                        TrendingCreatorsView()
                    }.background(Color.discoverBackground)
                    .cornerRadius(16)
                    .padding(.top, 32)
                }
            }.navigationTitle("Discover")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
