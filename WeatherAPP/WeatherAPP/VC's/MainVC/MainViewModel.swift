//
//  MainViewModel.swift
//  WeatherAPP
//
//  Created by Nor1 on 21.07.2023.
//

import Foundation

final class MainViewModel {
    
    typealias Routes = MainRoute
    private let route: Routes
        
    init(route: Routes){
        self.route = route
    }
}
