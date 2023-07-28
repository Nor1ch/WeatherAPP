//
//  DetailsRoute.swift
//  WeatherAPP
//
//  Created by Nor1 on 24.07.2023.
//

import Foundation

protocol DetailsRoute {
    func openDetails(city: MainCityModel)
}

extension DetailsRoute where Self: Router {
    func openDetails(with transition: Transition, city: MainCityModel){
        let router = MainRouter(rootTransition: transition)
        let viewModel = DetailsViewModel(route: router)
        let viewController = DetailsVC(viewModel: viewModel, city: city)
        router.root = viewController
        route(to: viewController, as: transition)
    }

    func openDetails(city: MainCityModel){
       openDetails(with: PushTransition(),city: city)
    }
}
extension MainRouter : DetailsRoute {}
