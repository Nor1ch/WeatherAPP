//
//  SearchVC.swift
//  WeatherAPP
//
//  Created by Nor1 on 26.07.2023.
//

import Foundation
import Combine
import UIKit
import DropDown

protocol SearchVCDelegate: AnyObject {
    func getWeather(city: MainCityModel)
}

private extension CGFloat {
    static let offset25 = 25.0
    static let textFieldHeight = 60.0
}

final class SearchVC: UIViewController {
    private let viewModel: SearchViewModel
    private var cancellable = Set<AnyCancellable>()
    
    weak var delegate: SearchVCDelegate?
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField()
        view.textAlignment = .center
        view.placeholder = "What are you looking for?"
        view.textColor = .black
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.clipsToBounds = true
        return view
    }()
    private lazy var dropDownMenu: DropDown = {
        let view = DropDown(anchorView: searchTextField)
        view.bottomOffset = CGPoint(x: 0, y: CGFloat.textFieldHeight)
        view.topOffset = CGPoint(x: 0, y: 0)
        view.direction = .bottom
        return view
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    init(viewModel: SearchViewModel){
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
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        view.addSubview(activityIndicator)
        searchTextField.delegate = self
    }
    private func makeConstraints(){
        searchTextField.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().inset(CGFloat.offset25)
            make.height.equalTo(CGFloat.textFieldHeight)
        }
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    private func bind(){
        dropDownMenu.selectionAction = { [weak self] (index, _) in
            guard let self = self else { return }
            self.searchTextField.isEnabled = false
            self.activityIndicator.startAnimating()
            self.viewModel.cityPicked(city: self.viewModel.citiesArray.array[index])
        }
        
        searchTextField.textPublisher
            .assign(to: \.cityName, on: self.viewModel)
            .store(in: &cancellable)
        viewModel.$citiesArray
            .sink(receiveValue: { [weak self] citiesGeo in
                guard let self = self else { return }
                self.dropDownMenu.dataSource = citiesGeo.array.map {$0.name + " " + $0.country + " " + $0.state}
                self.dropDownMenu.show()
            })
            .store(in: &cancellable)
        viewModel.$pickedCity
            .sink { [weak self] model in
                guard let self = self else { return }
                if let model = model {
                    self.delegate?.getWeather(city: model)
                    self.viewModel.close()
                        } else {
                            self.viewModel.close()
                }
            }
            .store(in: &cancellable)
    }
}

extension SearchVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
