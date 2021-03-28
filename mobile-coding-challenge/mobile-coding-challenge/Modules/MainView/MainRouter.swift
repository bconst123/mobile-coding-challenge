//
//  MainRouter.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation
import UIKit

final class MainRouter {
    private weak var delegate: MainRouterDelegate?
    
    init(delegate: MainRouterDelegate?) {
        self.delegate = delegate
    }
    
    func showImage(arrayImages: [UnsplashModel], index: Int) {
        let storyboard = UIStoryboard(name: MainViewConstants.Strings.storyboardId, bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: MainViewConstants.Strings.controllerId) as? DetailsView {
            controller.setup(arrayImages: arrayImages, index: index)
            delegate?.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
