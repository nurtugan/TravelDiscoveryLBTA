//
//  DestinationHeaderView.swift
//  TravelDiscoveryLBTA
//
//  Created by Nurtugan Nuraly on 7/4/21.
//

import SwiftUI

struct DestinationHeaderView: UIViewControllerRepresentable {
    let imageNames: [String]
    
    init(imageNames: [String]) {
        self.imageNames = imageNames
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = CustomPageViewController(imageNames: imageNames)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

final class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var allVCs: [UIViewController] = []
    
    init(imageNames: [String]) {
        UIPageControl.appearance().pageIndicatorTintColor = .systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemBlue
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        allVCs = imageNames.map { imageName in
            let image = Image(imageName)
                .resizable()
                .scaledToFill()
            let vc = UIHostingController(rootView: image)
            vc.view.clipsToBounds = true
            return vc
        }
        setViewControllers([allVCs.first!], direction: .forward, animated: true, completion: nil)
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
    static var previews: some View {
        NavigationView {
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235))
        }
        DestinationHeaderView(imageNames: ["eiffel_tower", "art1", "art2"])
    }
}
