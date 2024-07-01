//
//  ViewController.swift
//  memo
//
//  Created by 조윤경 on 2024/02/03.
//

import UIKit

class ViewController: UIViewController {
    private let tableViewController = ListViewController()
    var planeSceneView: PlaneSceneView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add TestViewController as a child view controller
        addChild(tableViewController)
        view.addSubview(tableViewController.view)
        tableViewController.didMove(toParent: self)
//
//        // Optional: Set up constraints if needed
//        tableViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            tableViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//        ])
        planeSceneView = PlaneSceneView(frame: self.view.frame)
//        self.view.addSubview(planeSceneView)
    }

    // Optional: Override viewDidLayoutSubviews to handle additional layout updates
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        // Additional layout adjustments if necessary
//    }allowsCameraControl
}
