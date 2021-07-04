//
//  DestinationHeaderView.swift
//  TravelDiscoveryLBTA
//
//  Created by Nurtugan Nuraly on 7/4/21.
//

import SwiftUI

struct DestinationHeaderView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemRed
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct DestinationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationHeaderView()
    }
}
