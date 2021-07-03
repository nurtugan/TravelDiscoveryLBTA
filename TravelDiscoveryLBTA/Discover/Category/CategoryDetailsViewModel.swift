//
//  CategoryDetailsViewModel.swift
//  TravelDiscoveryLBTA
//
//  Created by Nurtugan Nuraly on 7/4/21.
//

import Foundation

final class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var places: [Place] = []
    @Published var errorMessage = ""
    
    init() {
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/category?name=art") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.isLoading = false
            guard let data = data else { return }
            do {
                self.places = try JSONDecoder().decode([Place].self, from: data)
            } catch {
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
            }
        }.resume()
    }
}
