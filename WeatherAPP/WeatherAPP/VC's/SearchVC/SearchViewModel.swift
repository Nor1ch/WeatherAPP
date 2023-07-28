//
//  SearchViewModel.swift
//  WeatherAPP
//
//  Created by Nor1 on 26.07.2023.
//

import Foundation
import Combine

final class SearchViewModel {
    
    @Published var cityName: String = ""
    @Published var citiesArray: CitiesGeoRequest = CitiesGeoRequest.makePlaceholder()
    @Published var pickedCity: MainCityModel? 
    
    private var cancellable = Set<AnyCancellable>()
    
    typealias Routes = MainRouter
    private let route: Routes
    private let api: IAPI
    
    init(route: Routes, api: IAPI){
        self.api = api
        self.route = route
        $cityName
            .debounce(for: 1, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { self.api.publisherGeocoding(city: $0) }
            .assign(to: \.citiesArray, on: self)
            .store(in: &cancellable)
    }
    
    func close(){
        route.close()
    }
    func cityPicked(city: CityModel){
        api.publisherWeather(lat: city.lat, lon: city.lon)
            .map { model -> MainCityModel? in
                return model.array.first
            }
            .assign(to: \.pickedCity, on: self)
            .store(in: &cancellable)
            
    }
}
