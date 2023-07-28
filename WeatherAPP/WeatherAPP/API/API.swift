//
//  API.swift
//  WeatherAPP
//
//  Created by Nor1 on 27.07.2023.
//

import Foundation
import Combine
import UIKit


private enum Token: String {
    case geo = "885b7397a0170866c05850e52f934e34"
    
}
protocol IAPI {
    func publisherGeocoding(city: String) -> AnyPublisher<CitiesGeoRequest, Never>
    func publisherWeather(lat: Double, lon: Double) -> AnyPublisher<MainCityModelCompl, Never>
}

final class API: IAPI {
    private let geoLimit = 6
    private let geoUrl = "http://api.openweathermap.org/geo/1.0/direct?q="
    private let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat="
    
    func publisherWeather(lat: Double, lon: Double) -> AnyPublisher<MainCityModelCompl, Never> {
        guard let url = self.url(string: weatherUrl + "\(lat)" + "&lon=" + "\(lon)" + "&appid=" + Token.geo.rawValue + "&units=metric") else {
            return Just(MainCityModelCompl.makePlaceholder()).eraseToAnyPublisher()
        }
        print(url)
        return fetch(url)
            .map { (response: MainCityModel) -> MainCityModelCompl in
                return MainCityModelCompl(array: [response])
            }
            .replaceError(with: MainCityModelCompl.makePlaceholder())
            .eraseToAnyPublisher()
    }
    
    func publisherGeocoding(city: String) -> AnyPublisher<CitiesGeoRequest, Never> {
        if city != "" {
        guard let url = self.url(string: geoUrl + "\(city)" + "&limit=" + "\(geoLimit)" + "&appid=" + "\(Token.geo.rawValue)") else {
            return Just(CitiesGeoRequest.makePlaceholder()).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: [CityModel]) -> CitiesGeoRequest in
                return CitiesGeoRequest(array: response)
            }
            .replaceError(with: CitiesGeoRequest.makePlaceholder())
            .eraseToAnyPublisher()
        }
        return Just(CitiesGeoRequest.makePlaceholder()).eraseToAnyPublisher()
    }
    
    private func fetch<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    private func fetchImage(_ url: String) -> AnyPublisher<UIImage, Never> {
        guard let url = self.url(string: url) else {
            return Just(UIImage()).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) ?? UIImage() }
            .replaceError(with: UIImage())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    private func url(string: String) -> URL? {
        URL(string: string)
    }
}
