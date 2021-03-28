//
//  ViewController.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import UIKit

class MainView: UIViewController {

    // MARK: - variables
    lazy var presenter: MainPresenter = .init(delegate: self, routerDelegate: self)
    
    // MARK: - outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.callApi(startAt: 0)
        title = presenter.getViewName()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MainView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getImageArray().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewConstants.Strings.cellIdentifier, for: indexPath)
        
        if let cellImage = cell.viewWithTag(MainViewConstants.Ints.iamgeViewTag) as? UIImageView,
            let imageUrl = presenter.getImageArray()[indexPath.row].urls?.thumb {
            cellImage.downloadImage(from: imageUrl)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2) - MainViewConstants.Constraints.margin,
                      height: MainViewConstants.Constraints.maxHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == presenter.getImageArray().count - 1) {
            presenter.callApi(startAt: ((indexPath.row+1)/MainViewConstants.Ints.numPagesInPagination)+1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        presenter.showImageDetails(index: indexPath.row)
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
