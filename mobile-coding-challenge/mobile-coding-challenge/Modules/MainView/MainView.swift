//
//  ViewController.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import UIKit

class MainView: UIViewController {

    // MARK: -
    lazy var presenter: MainPresenter = .init(delegate: self, routerDelegate: self)
    
    // MARK: -
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.callApi(startAt: 0)
    }
    
    func setup() {
        presenter.setup()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MainView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getImageArray().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewConstants.Strings.cellIdentifier, for: indexPath)
        
        if let cellImage = cell.viewWithTag(100) as? UIImageView,
            let imageUrl = presenter.getImageArray()[indexPath.row].links?.download {
            cellImage.downloadImage(from: imageUrl)
        }
        cell.widthAnchor.constraint(lessThanOrEqualToConstant: (UIScreen.main.bounds.width/2) - 10).isActive = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2) - 10, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if(indexPath.row == self.characterViewModel.charactersArray.count - 1) {
//            //last cell
//            if(self.characterViewModel.charactersArray.count < totalCharacters) {
//                //call API with offset = charactersArray.count
//                print("loading new data...")
//                callApi(startAt: self.characterViewModel.charactersArray.count)
//            }
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}

// MARK: - MainPresenterDelegate
extension MainView: MainPresenterDelegate {
    func didLoad() {
        DispatchQueue.main.async() { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - MainRouterDelegate
extension MainView: MainRouterDelegate {
    
}
