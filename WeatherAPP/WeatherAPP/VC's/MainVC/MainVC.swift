//
//  MainVC.swift
//  WeatherAPP
//
//  Created by Nor1 on 21.07.2023.
//

import Foundation
import SnapKit
import Combine
import UIKit

private extension CGFloat {
    static let offset20 = 20.0
    static let offset15 = 15.0
    static let multipliedBy07 = 0.7
    static let alpha02 = 0.2
    static let rowHeight = 100.0
    static let cornerRadius = 15.0
}

final class MainVC: UIViewController {
    
    private var viewModel: MainViewModel
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var containterBackground: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = Constants.Images.snow_background
        view.contentMode = .scaleAspectFill
        return view
    }()
    private lazy var mainContainer: MainContainerView = {
        let view = MainContainerView()
        return view
    }()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.layer.cornerRadius = CGFloat.cornerRadius
        view.layer.masksToBounds = true
        view.rowHeight = CGFloat.rowHeight
        view.backgroundColor = .gray.withAlphaComponent(CGFloat.alpha02)
        return view
    }()
    
    init(viewModel: MainViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
        bind()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.setupLocationManager()
    }
    
    private func bind(){
        viewModel.$pickedCity
            .sink { city in
                guard let city = city else { return }
                self.mainContainer.setupViewWithCity(city: city)
            }
            .store(in: &cancellable)
    }
    private func setupViews() {
        view.addSubview(containterBackground)
        containterBackground.addSubview(backgroundImage)
        containterBackground.addSubview(mainContainer)
        containterBackground.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "\(MainCell.self)")
        tableView.register(MainCellAdd.self, forCellReuseIdentifier: "\(MainCellAdd.self)")
    }
    private func makeConstraints(){
        containterBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.offset15)
            make.bottom.equalToSuperview().inset(CGFloat.offset20)
            make.height.equalToSuperview().multipliedBy(CGFloat.multipliedBy07)
        }
    }
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.citiesArray.count
        default:
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainCell.self)") as? MainCell else { return UITableViewCell()}
            let item = viewModel.citiesArray[indexPath.row]
            cell.setupCell(city: item)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainCellAdd.self)") else { return UITableViewCell()}
            return cell
        }
    }
}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            viewModel.openDetails(city: viewModel.citiesArray[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        default:
            viewModel.openSearch()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension MainVC: SearchVCDelegate {
    func getWeather(city: MainCityModel) {
        viewModel.citiesArray.append(city)
        tableView.reloadData()
    }
}

