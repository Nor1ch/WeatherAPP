//
//  MainVC.swift
//  WeatherAPP
//
//  Created by Nor1 on 21.07.2023.
//

import Foundation
import UIKit

final class MainVC: UIViewController {
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
