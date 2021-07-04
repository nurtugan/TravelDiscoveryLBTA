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
    
    init(name: String) {
        guard let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.lowercased())"
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.isLoading = false
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            guard 200...299 ~= statusCode,
                  let data = data else {
                self.errorMessage = "Something went wrong. Status code: \(statusCode)"
                return
            }
            do {
                self.places = try JSONDecoder().decode([Place].self, from: data)
            } catch {
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
            }
        }.resume()
    }
}
