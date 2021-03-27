//
//  MainDefinitions.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Main Protocols

protocol MainInteractorDelegate: class {
    func didLoad(response: [UnsplashModel])
    func errorLoading()
}

protocol MainPresenterDelegate: class {
    func didLoad()
}

protocol MainRouterDelegate: class {
    var navigationController: UINavigationController? { get }
}

// MARK: - Constants
struct MainViewConstants {
    struct Strings {
        static let cellIdentifier = "collectionCell"
    }
}
