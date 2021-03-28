//
//  DetailsView.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import UIKit

class DetailsView: UIViewController {

    // MARK: - variables
    lazy var presenter: DetailsPresenter = .init(delegate: self, routerDelegate: self)
    
    // MARK: - outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
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

// MARK: - Gestures Handlers
extension DetailsView {
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .right {
            if presenter.subtractOneToImage() {
                imageView.rightToLeftAnimation()
                setUpView()
            }
       } else if gesture.direction == .left {
            if presenter.addOneToImage() {
                imageView.leftToRightAnimation()
                setUpView()
            }
       }
    }
}

// MARK: - MainPresenterDelegate
extension DetailsView: DetailsPresenterDelegate { }

// MARK: - MainRouterDelegate
extension DetailsView: DetailsRouterDelegate { }

// MARK: - ZoomAnimationDelegate
extension DetailsView: ZoomViewController {
    func zoomBackgroundView(for transition: ZoomAnimationDelegate) -> UIView? {
        return nil
    }
    
    func zoomImageView(for transition: ZoomAnimationDelegate) -> UIImageView? {
        return imageView
    }
}
