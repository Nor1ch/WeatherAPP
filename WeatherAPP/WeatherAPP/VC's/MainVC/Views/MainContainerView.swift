//
//  MainContainerView.swift
//  WeatherAPP
//
//  Created by Nor1 on 24.07.2023.
//

import Foundation
import UIKit

private extension CGFloat {
    static let multipliedBy048 = 0.48
    static let offset5 = 5.0
}

class MainContainerView: UIView {
    
    private lazy var cityLabel: UILabel = {
        let view = UILabel()
        view.text = "-//-"
        view.font = Constants.Fonts.MainScreen.cityTitle
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        view.text = "-//-"
        view.font = Constants.Fonts.MainScreen.tempLabel
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    private lazy var weatherLabel: UILabel = {
        let view = UILabel()
        view.text = "-//-"
        view.font = Constants.Fonts.MainScreen.weatherLabel
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    private lazy var tempMinLabel: UILabel = {
        let view = UILabel()
        view.text = "Min: -//-"
        view.font = Constants.Fonts.MainScreen.tempMinLabel
        view.textAlignment = .right
        view.textColor = .white
        return view
    }()
    private lazy var tempMaxLabel: UILabel = {
        let view = UILabel()
        view.text = "Max: -//-"
        view.font = Constants.Fonts.MainScreen.tempMaxLabel
        view.textAlignment = .left
        view.textColor = .white
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
    
    func setupViewWithCity(city: MainCityModel){
        cityLabel.text = city.name
        tempLabel.text = String(city.main.temp) + "°"
        weatherLabel.text = city.weather.first?.main
        tempMinLabel.text = "Min: " + String(city.main.tempMin) + "°"
        tempMaxLabel.text = "Max: " + String(city.main.tempMax) + "°"
    }
    
    private func setupViews(){
        addSubview(cityLabel)
        addSubview(tempLabel)
        addSubview(weatherLabel)
        addSubview(tempMinLabel)
        addSubview(tempMaxLabel)
    }
    private func makeConstraints(){
        cityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(CGFloat.offset5)
            make.centerX.equalToSuperview()
        }
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(CGFloat.offset5)
            make.centerX.equalToSuperview()
        }
        tempMinLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(CGFloat.multipliedBy048)
        }
        tempMaxLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom)
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(CGFloat.multipliedBy048)
        }
    }
}
