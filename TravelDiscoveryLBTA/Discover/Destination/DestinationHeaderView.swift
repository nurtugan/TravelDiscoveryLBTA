//
//  DestinationHeaderView.swift
//  TravelDiscoveryLBTA
//
//  Created by Nurtugan Nuraly on 7/4/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DestinationHeaderView: UIViewControllerRepresentable {
    let imageURLStrings: [String]
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = CustomPageViewController(imageURLStrings: imageURLStrings)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

final class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var allVCs: [UIViewController] = []
    
    init(imageURLStrings: [String]) {
        UIPageControl.appearance().pageIndicatorTintColor = .systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemBlue
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        allVCs = imageURLStrings.map { imageName in
            let image = AnimatedImage(url: URL(string: imageName))
                .resizable()
                .scaledToFill()
                .transition(.fade)
            let vc = UIHostingController(rootView: image)
            vc.view.clipsToBounds = true
            return vc
        }
        if let firstVC = allVCs.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Data Source
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allVCs.firstIndex(of: viewController) else { return nil }
        if index == 0 { return nil }
        return allVCs[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = allVCs.firstIndex(of: viewController) else { return nil }
        if index == allVCs.count - 1 { return nil }
        return allVCs[index + 1]
    }
    
    // MARK: Delegate
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allVCs.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}

struct DestinationHeaderView_Previews: PreviewProvider {
    static let imageURLStrings = [
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/7156c3c6-945e-4284-a796-915afdc158b5",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/b1642068-5624-41cf-83f1-3f6dff8c1702",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/6982cc9d-3104-4a54-98d7-45ee5d117531",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/2240d474-2237-4cd3-9919-562cd1bb439e"
    ]
    
    static var previews: some View {
        DestinationHeaderView(imageURLStrings: imageURLStrings)
            .frame(height: 300)
        NavigationView {
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235))
        }
    }
}
