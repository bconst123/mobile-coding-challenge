//
//  UIImage+Extensions.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import UIKit

private var imageCache: [String:UIImage] = [:]

extension UIImageView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }
    
    public func downloadImage(from stringUrl: String) {
        let activityIndicator = self.activityIndicator

        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
        if let imageLoaded = imageCache[stringUrl] {
            DispatchQueue.main.async() { [weak self] in
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                self?.image = imageLoaded
            }
        } else {
            if let url = URL(string: stringUrl) {
                getData(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() { [weak self] in
                        activityIndicator.stopAnimating()
                        activityIndicator.removeFromSuperview()
                        imageCache[stringUrl] = UIImage(data: data)
                        self?.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
