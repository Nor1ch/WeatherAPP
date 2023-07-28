//
//  Constants.swift
//  WeatherAPP
//
//  Created by Nor1 on 21.07.2023.
//

import Foundation
import UIKit

enum Constants {
    enum Images {
        static var day_background: UIImage? {
            UIImage(named: "day_background")
        }
        static var night_background: UIImage? {
            UIImage(named: "night_background")
        }
        static var rain_background: UIImage? {
            UIImage(named: "rain_background")
        }
        static var snow_background: UIImage? {
            UIImage(named: "snow_background")
        }
        static var storm_background: UIImage? {
            UIImage(named: "storm_background")
        }
        static var sunset: UIImage? {
            UIImage(named: "sunset")
        }
        static var sunrise: UIImage? {
            UIImage(named: "sunrise")
        }
        static var wind: UIImage? {
            UIImage(named: "wind")
        }
    }
    
    enum Fonts {
        enum MainScreen {
            static var cityTitle: UIFont? {
                UIFont(name: "Graphik-Semibold", size: 26)
            }
            static var tempLabel: UIFont? {
                UIFont(name: "Graphik-Medium", size: 32)
            }
            static var weatherLabel: UIFont? {
                UIFont(name: "Graphik-Medium", size: 24)
            }
            static var tempMinLabel: UIFont? {
                UIFont(name: "GraphikLight", size: 12)
            }
            static var tempMaxLabel: UIFont? {
                UIFont(name: "GraphikLight", size: 12)
            }
        }
        enum DetailsScreen {
            static var cityTitle: UIFont? {
                UIFont(name: "Graphik-Semibold", size: 32)
            }
            static var weatherText: UIFont? {
                UIFont(name: "GraphikLight", size: 16)
            }
            static var feelsLike: UIFont? {
                UIFont(name: "GraphikLight", size: 26)
            }
            static var wind: UIFont? {
                UIFont(name: "Graphik-Medium", size: 8)
            }
        }
    }
}
