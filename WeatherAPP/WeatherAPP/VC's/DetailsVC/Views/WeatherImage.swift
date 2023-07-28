//
//  WeatherImage.swift
//  WeatherAPP
//
//  Created by Nor1 on 24.07.2023.
//

import Foundation
import UIKit

private extension CGFloat {
    static let offset = 10.0
    static let cornerRadius = 10.0
    static let alpha06 = 0.6
}
final class WeatherImage: UIView {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    init(image: UIImage?){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        backgroundColor = .white.withAlphaComponent(CGFloat.alpha06)
        layer.cornerRadius = CGFloat.cornerRadius
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(CGFloat.offset)
        }
        imageView.image = image
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
