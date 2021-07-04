//
//  CategoryDetailsView.swift
//  TravelDiscoveryLBTA
//
//  Created by Nurtugan Nuraly on 7/4/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryDetailsView: View {
    private let name: String
    @ObservedObject var vm: CategoryDetailsViewModel
    
    init(name: String) {
        self.name = name
        self.vm = .init(name: name)
    }
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                VStack {
                    ActivityIndicatorView()
                    Text("Loading...")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding()
                .background(Color(white: 0.2, opacity: 1))
                .cornerRadius(8)
            } else {
                ZStack {
                    if !vm.errorMessage.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "xmark.octagon.fill")
                                .font(.system(size: 64, weight: .semibold))
                                .foregroundColor(.red)
                            Text(vm.errorMessage)
                                .multilineTextAlignment(.center)
                        }.padding()
                    }
                    ScrollView {
                        ForEach(vm.places, id: \.self) { place in
                            VStack(alignment: .leading, spacing: 0) {
                                AnimatedImage(url: URL(string: place.thumbnail))
                                    .resizable()
                                    .scaledToFill()
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(place.name)
                                        .font(.system(size: 14, weight: .semibold))
                                    Text(place.country)
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                }.padding(.all, 10)
                            }.asTile()
                            .padding()
                        }
                    }
                }
            }
        }.navigationBarTitle(name, displayMode: .inline)
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(name: "Art")
        }
    }
}
