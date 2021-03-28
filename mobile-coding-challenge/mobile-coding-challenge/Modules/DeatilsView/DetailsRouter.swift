//
//  DetailsRouter.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation

final class DetailsRouter {
    private weak var delegate: DetailsRouterDelegate?
    
    init(delegate: DetailsRouterDelegate?) {
        self.delegate = delegate
    }
}
