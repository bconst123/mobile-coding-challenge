//
//  MainPresenter.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation

final class MainPresenter {
    private lazy var interactor: MainInteractor = .init(delegate: self)
    private weak var delegate: MainPresenterDelegate?
    private var router: MainRouter?
    private var imageArray: [UnsplashModel]?
    
    init(delegate: MainPresenterDelegate?, routerDelegate: MainRouterDelegate?) {
        self.delegate = delegate
        router = .init(delegate: routerDelegate)
    }
    
    func setup() {
        
    }
    
    func callApi(startAt: Int) {
        interactor.fetchUnsplashAPI(offset: startAt)
    }
    
    func getImageArray() -> [UnsplashModel] {
        if let imageArray = imageArray {
            return imageArray
        }
        return []
    }
}

// MARK: -
extension MainPresenter: MainInteractorDelegate {
    func errorLoading() {
        print("Error")
    }
    
    func didLoad(response: [UnsplashModel]) {
        imageArray = response
        delegate?.didLoad()
    }
}
