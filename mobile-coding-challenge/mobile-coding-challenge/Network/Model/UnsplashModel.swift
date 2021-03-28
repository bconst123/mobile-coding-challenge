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
    let urls: URLs?
    let links: Link?
    let user: User?
    let altDescription: String?
}

// MARK: - Link
public struct Link: Codable {
    let download: String?
}

// MARK: - URLs
public struct URLs: Codable {
    let thumb: String?
}

// MARK: - User
public struct User: Codable {
    let name: String?
}
