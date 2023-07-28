//
//  SearchRoute.swift
//  WeatherAPP
//
//  Created by Nor1 on 26.07.2023.
//

import Foundation

protocol SearchRoute {
    func openSearch()
}

extension SearchRoute where Self: Router {
    func openSearch(with transition: Transition){
        let router = MainRouter(rootTransition: transition)
        let api = API()
        let viewModel = SearchViewModel(route: router, api: api)
        let viewController = SearchVC(viewModel: viewModel)
        router.root = viewController
        route(to: viewController, as: transition)
    }

   func openSearch(){
       openSearch(with: ModalTransition())
    }
}
extension MainRouter : SearchRoute {}
