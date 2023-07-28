//
//  TempView.swift
//  WeatherAPP
//
//  Created by Nor1 on 24.07.2023.
//

import Foundation
import UIKit

private extension CGFloat {
    static let offset10 = 10.0
    static let offset15 = 15.0
    static let multipliedBy038 = 0.38
    static let multipliedBy1_6 = 1.6
    static let alpha03 = 0.3
    static let cornerRadius = 15.0
    static let imageSize = 80.0
    static let imageSizeSunState = 40.0
}

final class WeatherView: UIView {
    
    private lazy var tempContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(CGFloat.alpha03)
        view.layer.cornerRadius = CGFloat.cornerRadius
        return view
    }()
    private lazy var windContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(CGFloat.alpha03)
        view.layer.cornerRadius = CGFloat.cornerRadius
        return view
    }()
    private lazy var cityLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.DetailsScreen.cityTitle
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    private lazy var weatherImage: UIImageView = {
        let view = UIImageView()
        view.image = Constants.Images.snow_background
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var currentTemp: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.DetailsScreen.weatherText
        view.textColor = .white
        return view
    }()
    private lazy var minTemp: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.DetailsScreen.weatherText
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    private lazy var maxTemp: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.DetailsScreen.weatherText
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    private lazy var feelsLike: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.DetailsScreen.weatherText
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    private lazy var mainWeatherLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.DetailsScreen.weatherText
        view.text = "Clouds"
        view.textColor = .white
        return view
    }()
    private lazy var mainWeatherImage: WeatherImage = {
        let view = WeatherImage(image: Constants.Images.sunrise)
        return view
    }()
    private lazy var windWeatherLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.DetailsScreen.weatherText
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    private lazy var windWeatherImage: WeatherImage = {
        let view = WeatherImage(image: Constants.Images.wind)
        return view
    }()
    private lazy var sunsetWeatherLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.DetailsScreen.weatherText
        view.text = "17:45"
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    private lazy var sunsetWeatherImage: WeatherImage = {
        let view = WeatherImage(image: Constants.Images.sunset)
        return view
    }()
    private lazy var sunriseWeatherLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.DetailsScreen.weatherText
        view.text = "21:45"
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    private lazy var sunriseWeatherImage: WeatherImage = {
        let view = WeatherImage(image: Constants.Images.sunrise)
        return view
    }()
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupViews()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews(){
        addSubview(tempContainer)
        tempContainer.addSubview(cityLabel)
        tempContainer.addSubview(weatherImage)
        tempContainer.addSubview(minTemp)
        tempContainer.addSubview(currentTemp)
        tempContainer.addSubview(maxTemp)
        tempContainer.addSubview(feelsLike)
        
        addSubview(windContainer)
        windContainer.addSubview(mainWeatherLabel)
        windContainer.addSubview(mainWeatherImage)
        windContainer.addSubview(windWeatherImage)
        windContainer.addSubview(windWeatherLabel)
        windContainer.addSubview(sunsetWeatherImage)
        windContainer.addSubview(sunsetWeatherLabel)
        windContainer.addSubview(sunriseWeatherImage)
        windContainer.addSubview(sunriseWeatherLabel)
    }
    private func makeConstraints(){
        
        tempContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(CGFloat.offset10)
            make.bottom.equalTo(feelsLike.snp.bottom).offset(CGFloat.offset10)
        }
        cityLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(CGFloat.offset10)
        }
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(CGFloat.offset10)
            make.width.height.equalTo(CGFloat.imageSize)
            make.centerX.equalToSuperview()
        }
        currentTemp.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp.bottom).offset(CGFloat.offset10)
            make.centerX.equalToSuperview()
        }
        minTemp.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp.bottom).offset(CGFloat.offset10)
            make.right.equalTo(currentTemp.snp.left)
            make.left.equalToSuperview()
        }
        maxTemp.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp.bottom).offset(CGFloat.offset10)
            make.left.equalTo(currentTemp.snp.right)
            make.right.equalToSuperview()
        }
        feelsLike.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentTemp.snp.bottom).offset(CGFloat.offset10)
        }
        
        windContainer.snp.makeConstraints { make in
            make.top.equalTo(tempContainer.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(CGFloat.offset10)
            make.bottom.equalTo(windWeatherLabel.snp.bottom).offset(CGFloat.offset10)
        }
        mainWeatherImage.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.imageSize)
            make.top.equalToSuperview().offset(CGFloat.offset10)
            make.centerX.equalToSuperview()
        }
        mainWeatherLabel.snp.makeConstraints { make in
            make.top.equalTo(mainWeatherImage.snp.bottom)
            make.centerX.equalToSuperview()
        }
        windWeatherImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset10)
            make.centerX.equalToSuperview().multipliedBy(CGFloat.multipliedBy038)
            make.width.height.equalTo(CGFloat.imageSize)
        }
        windWeatherLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(mainWeatherImage.snp.left)
            make.top.equalTo(windWeatherImage.snp.bottom)
        }
        sunriseWeatherImage.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.imageSizeSunState)
            make.top.equalToSuperview().offset(CGFloat.offset10)
            make.centerX.equalToSuperview().multipliedBy(CGFloat.multipliedBy1_6)
        }
        sunriseWeatherLabel.snp.makeConstraints { make in
            make.top.equalTo(sunsetWeatherImage.snp.bottom)
            make.centerX.equalTo(sunsetWeatherImage.snp.centerX)
        }
        sunsetWeatherImage.snp.makeConstraints { make in
            make.top.equalTo(sunsetWeatherLabel.snp.bottom).offset(CGFloat.offset10)
            make.centerX.equalToSuperview().multipliedBy(CGFloat.multipliedBy1_6)
            make.width.height.equalTo(CGFloat.imageSizeSunState)
        }
        sunsetWeatherLabel.snp.makeConstraints { make in
            make.top.equalTo(sunriseWeatherImage.snp.bottom)
            make.centerX.equalTo(sunsetWeatherImage.snp.centerX)
        }
    }
    
    func setupViewwithCity(city: MainCityModel){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let dateSunrise = Date(timeIntervalSince1970: Double(city.sys.sunrise))
        let dateSunset = Date(timeIntervalSince1970: Double(city.sys.sunset))
        cityLabel.text = city.name
        currentTemp.text = "Current: " + String(city.main.temp) + "°"
        minTemp.text = "Min: " + String(city.main.tempMin) + "°"
        maxTemp.text = "Max: " + String(city.main.tempMax) + "°"
        feelsLike.text = "Feels like: " + String(city.main.feelsLike) + "°"
        windWeatherLabel.text = "Speed: " + String(city.wind.speed) + " Deg: " + String(city.wind.deg)
        sunsetWeatherLabel.text = formatter.string(from: dateSunrise)
        sunriseWeatherLabel.text = formatter.string(from: dateSunset)
        if let weather = city.weather.first {
            mainWeatherLabel.text = weather.main
        }
    }
}
