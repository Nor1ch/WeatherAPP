//
//  MainCell.swift
//  WeatherAPP
//
//  Created by Nor1 on 24.07.2023.
//
import Foundation
import UIKit

private extension CGFloat {
    static let offsetParent = 5.0
    static let containerCornerRadius = 20.0
    static let offset10 = 10.0
    static let multipliedBy05 = 0.5
    static let multipliedBy1_5 = 1.5
}

final class MainCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = CGFloat.containerCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var weatherImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = Constants.Images.night_background
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var weatherName: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.MainScreen.cityTitle
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    private lazy var weatherTemp: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.MainScreen.tempLabel
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        makeConstraints()
        weatherImage.layer.cornerRadius = weatherImage.frame.size.width
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews(){
        addSubview(containerView)
        containerView.addSubview(weatherImage)
        containerView.addSubview(weatherTemp)
        containerView.addSubview(weatherName)
        layer.masksToBounds = true
        backgroundColor = .clear
    }
    private func makeConstraints(){
        containerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(CGFloat.offsetParent)
            make.right.bottom.equalToSuperview().inset(CGFloat.offsetParent)
        }
        weatherImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        weatherTemp.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset10)
            make.bottom.equalToSuperview().inset(CGFloat.offset10)
            make.centerX.equalToSuperview().multipliedBy(CGFloat.multipliedBy1_5)
        }
        weatherName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset10)
            make.bottom.equalToSuperview().inset(CGFloat.offset10)
            make.left.equalToSuperview().offset(CGFloat.offsetParent)
            make.width.equalToSuperview().multipliedBy(CGFloat.multipliedBy05)
        }
    }
    func setupCell(city: MainCityModel){
        weatherName.text = city.name
        weatherTemp.text = String(city.main.temp) + "°C"
    }
}
