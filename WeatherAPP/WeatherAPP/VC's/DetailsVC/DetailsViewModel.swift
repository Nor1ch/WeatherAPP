//
//  DetailsViewModel.swift
//  WeatherAPP
//
//  Created by Nor1 on 24.07.2023.
//

import Foundation

final class DetailsViewModel {
    typealias Routes = MainRouter
    private let route: Routes
    
    init(route: Routes){
        self.route = route
    }
    
    func close(){
        route.close()
    }
}
