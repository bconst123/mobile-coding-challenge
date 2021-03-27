//
//  UnsplashModel.swift
//  mobile-coding-challenge
//
//  Created by Bruno Augusto Constantino on 3/27/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import Foundation

struct UnsplashModel: Codable {
    let id: String?
    let links: Link?
    let altDescription: String?
}

// MARK: - DataClass
public struct Link: Codable {
    let download: String?
}
