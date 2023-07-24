//
//  EmptyTransition.swift
//  WeatherAPP
//
//  Created by Nor1 on 21.07.2023.
//

import Foundation
import UIKit

final class EmptyTransition : Transition {
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {}
    
    func close(_ viewController: UIViewController, completion: (() -> Void)?) {}
}
