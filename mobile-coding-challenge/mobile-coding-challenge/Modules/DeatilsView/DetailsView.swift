//
//  DetailsView.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import UIKit

class DetailsView: UIViewController {

    // MARK: -
    lazy var presenter: DetailsPresenter = .init(delegate: self, routerDelegate: self)
    
    // MARK: -
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setup(arrayImages: [UnsplashModel], index: Int) {
        presenter.setup(arrayImages: arrayImages, selectedIndex: index)
    }
    
    func setUpView() {
        if let imageUrl = presenter.getImageUrl() {
            imageView.downloadImage(from: imageUrl)
        }
        if let imageUserName = presenter.getImageUserName() {
            labelID.text = imageUserName
        }
        if let imageDescription = presenter.getImageDescription() {
            labelDescription.text = imageDescription
            labelDescription.layoutIfNeeded()
        }
    }
}

// MARK: - MainPresenterDelegate
extension DetailsView: DetailsPresenterDelegate {
    func didLoad() {
        
    }
}

// MARK: - MainRouterDelegate
extension DetailsView: DetailsRouterDelegate {
    
}
