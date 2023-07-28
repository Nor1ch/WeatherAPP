//
//  DetailsVC.swift
//  WeatherAPP
//
//  Created by Nor1 on 24.07.2023.
//

import Foundation
import UIKit


final class DetailsVC: UIViewController {
    
    private let viewModel: DetailsViewModel
    private let city: MainCityModel
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = Constants.Images.rain_background
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var weatherView: WeatherView = {
        let view = WeatherView()
        return view
    }()
    init(viewModel: DetailsViewModel, city: MainCityModel){
        self.viewModel = viewModel
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews(){
        view.addSubview(containerView)
        containerView.addSubview(backgroundImage)
        containerView.addSubview(weatherView)
        weatherView.setupViewwithCity(city: city)
        
    }
    private func makeConstraints(){
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        weatherView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.3)
        }
    }
}
