//
//  ModalTransition.swift
//  WeatherAPP
//
//  Created by Nor1 on 21.07.2023.
//

import Foundation
import UIKit

final class ModalTransition : Transition {
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        viewController.modalPresentationStyle = .automatic
        if let vc = viewController as? SearchVC, let vcFrom = from as? SearchVCDelegate {
                    vc.delegate = vcFrom
                }
        from.present(viewController, animated: true, completion: completion)
    }
    
    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: true, completion: completion)
    }
}
