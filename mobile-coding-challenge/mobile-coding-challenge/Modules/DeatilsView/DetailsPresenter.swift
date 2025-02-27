//
//  DetailsPresenter.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation

final class DetailsPresenter {
    
    // MARK: - private variables
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
            return "\(DetailsViewConstants.Strings.createdLabel) \(imageUserName)"
        }
        return nil
    }
    
    func getImageDescription() -> String? {
        if let index = selectedIndex, let imageDescription = imageArray?[index].altDescription {
            return imageDescription
        }
        return nil
    }
    
    func addOneToImage() -> Bool {
        if let selectedIndex = selectedIndex, let imageArray = imageArray, imageArray.count - 1 >= selectedIndex + 1 {
            self.selectedIndex = selectedIndex + 1
            return true
        }
        return false
    }
    
    func subtractOneToImage() -> Bool {
        if let selectedIndex = selectedIndex, 0 <= selectedIndex - 1 {
            self.selectedIndex = selectedIndex - 1
            return true
        }
        return false
    }
}

// MARK: - DetailsInteractorDelegate
extension DetailsPresenter: DetailsInteractorDelegate {

}
