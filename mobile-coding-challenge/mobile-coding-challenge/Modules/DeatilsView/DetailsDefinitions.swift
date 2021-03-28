//
//  DetailsDefinitions.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Main Protocols

protocol DetailsInteractorDelegate: class {
}

protocol DetailsPresenterDelegate: class {
    func didLoad()
}

protocol DetailsRouterDelegate: class {
    var navigationController: UINavigationController? { get }
}

// MARK: - Constants
struct DetailsViewConstants {
    struct Strings {

    }
}
