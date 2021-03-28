//
//  DetailsInteractor.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation

final class DetailsInteractor {
    private weak var delegate: DetailsInteractorDelegate?
    
    init(delegate: DetailsInteractorDelegate?) {
        self.delegate = delegate
    }
}
