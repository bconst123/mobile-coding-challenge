//
//  DetailsPresenter.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation

final class DetailsPresenter {
    private lazy var interactor: DetailsInteractor = .init(delegate: self)
    private weak var delegate: DetailsPresenterDelegate?
    private var router: DetailsRouter?
    private var imageArray: [UnsplashModel]?
    private var selectedIndex: Int?
    
    init(delegate: DetailsPresenterDelegate?, routerDelegate: DetailsRouterDelegate?) {
        self.delegate = delegate
        router = .init(delegate: routerDelegate)
    }
    
    func setup(arrayImages: [UnsplashModel], selectedIndex: Int) {
        self.imageArray = arrayImages
        self.selectedIndex = selectedIndex
    }
    
    func getImageUrl() -> String? {
        if let index = selectedIndex, let imageUrl = imageArray?[index].links?.download {
            return imageUrl
        }
        return nil
    }
    
    func getImageUserName() -> String? {
        if let index = selectedIndex, let imageUserName = imageArray?[index].user?.name {
            return "Created by \(imageUserName)"
        }
        return nil
    }
    
    func getImageDescription() -> String? {
        if let index = selectedIndex, let imageDescription = imageArray?[index].altDescription {
            return imageDescription
        }
        return nil
    }
    
    func addOneToImage() {
        if let selectedIndex = selectedIndex {
            self.selectedIndex = selectedIndex + 1
        }
    }
    
    func subtractOneToImage() {
        if let selectedIndex = selectedIndex {
            self.selectedIndex = selectedIndex - 1
        }
    }
}

// MARK: - DetailsInteractorDelegate
extension DetailsPresenter: DetailsInteractorDelegate {

}
