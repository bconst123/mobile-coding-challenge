//
//  MainRouter.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation

final class MainRouter {
    private weak var delegate: MainRouterDelegate?
    
    init(delegate: MainRouterDelegate?) {
        self.delegate = delegate
    }
}
