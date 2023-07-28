//
//  MainViewModel.swift
//  WeatherAPP
//
//  Created by Nor1 on 21.07.2023.
//

import Foundation
import Combine
import CoreLocation



final class MainViewModel: NSObject {
    
    @Published var pickedCity: MainCityModel?
    
    var citiesArray: [MainCityModel] = []
    
    typealias Routes = DetailsRoute & SearchRoute
    private let route: Routes
    private let api = API()
    
    private var locationManager: CLLocationManager
    private var cancellable = Set<AnyCancellable>()
    private var currentLocation: CLLocationCoordinate2D?
        
    init(route: Routes){
        self.route = route
        locationManager = CLLocationManager()
        
    }
    
    func openDetails(city: MainCityModel){
        route.openDetails(city: city)
    }
    func openSearch(){
        route.openSearch()
    }
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension MainViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty && currentLocation == nil {
            currentLocation = locations.first?.coordinate
            locationManager.stopUpdatingLocation()
            guard let lat = currentLocation?.latitude, let lon = currentLocation?.longitude else { return }
            
            api.publisherWeather(lat: lat, lon: lon)
                .map { model -> MainCityModel? in
                    return model.array.first
                }
                .assign(to: \.pickedCity, on: self)
                .store(in: &cancellable)
        }
    }
}
