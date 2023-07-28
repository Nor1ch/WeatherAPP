//
//  GeocodingAPI.swift
//  WeatherAPP
//
//  Created by Nor1 on 26.07.2023.
//

import Foundation

struct CityModel: Codable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    let country, state: String
    
        enum CodingKeys: String, CodingKey {
            case name
            case localNames = "local_names"
            case lat, lon, country, state
        }
}
struct CitiesGeoRequest: Decodable {
    let array: [CityModel]
    
    static func makePlaceholder() -> CitiesGeoRequest {
        return CitiesGeoRequest(array: [])
    }
}
