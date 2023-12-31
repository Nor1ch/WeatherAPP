//
//  MainRoute.swift
//  WeatherAPP
//
//  Created by Nor1 on 21.07.2023.
//

import Foundation
import UIKit

protocol MainRoute {
    func makeMain() -> UIViewController
}


extension MainRoute where Self: Router {
    func makeMain() -> UIViewController {
        let router = MainRouter(rootTransition: EmptyTransition())
        let viewModel = MainViewModel(route: router)
        let viewController = MainVC(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        router.root = viewController
        return navigation
    }
}

extension MainRouter : MainRoute {}
