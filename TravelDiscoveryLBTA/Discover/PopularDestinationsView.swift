//
//  PopularDestinationsView.swift
//  TravelDiscoveryLBTA
//
//  Created by Nurtugan Nuraly on 7/2/21.
//

import SwiftUI

struct PopularDestinationsView: View {
    private let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "eiffel_tower"),
        .init(name: "Tokyo", country: "Japan", imageName: "japan"),
        .init(name: "New York", country: "US", imageName: "new_york")
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Popular destinations")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }.padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(destinations, id: \.self) { destination in
                        NavigationLink(
                            destination: PopularDestinationDetailsView(destination: destination),
                            label: {
                                PopularDestinationTileView(destination: destination)
                            }
                        )
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eiffel_tower"))
        }
        DiscoverView()
        PopularDestinationsView()
    }
}

struct PopularDestinationDetailsView: View {
    let destination: Destination
    
    var body: some View {
        ScrollView {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .clipped()
            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.system(size: 18, weight: .bold))
                Text(destination.country)
                HStack(spacing: 4) {
                    ForEach(0..<5, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }.padding(.top, 2)
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                    .padding(.top, 4)
                HStack { Spacer() }
            }.padding(.horizontal)
        }.navigationBarTitle(destination.name, displayMode: .inline)
    }
}

struct PopularDestinationTileView: View {
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .cornerRadius(5)
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
            Text(destination.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .foregroundColor(Color(.label))
            Text(destination.country)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.secondary)
        }
        .asTile()
        .padding(.bottom)
    }
}
