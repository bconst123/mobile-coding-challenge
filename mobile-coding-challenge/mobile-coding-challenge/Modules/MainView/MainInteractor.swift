//
//  MainInteractor.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation

final class MainInteractor {
    private weak var delegate: MainInteractorDelegate?
    private let apiManager = ApiManager()
    
    init(delegate: MainInteractorDelegate?) {
        self.delegate = delegate
    }

    func fetchUnsplashAPI(offset: Int) {
        apiManager.createArrayFromAPI(offset: offset) { [weak self] (result, error) in
            if let error = error {
                print("ERROR: \(error)")
                self?.delegate?.errorLoading()
                return
            }
            guard let responseData = result else {
                print("Data is nil")
                self?.delegate?.errorLoading()
                return
            }
            self?.delegate?.didLoad(response: responseData)
        }
    }
}
