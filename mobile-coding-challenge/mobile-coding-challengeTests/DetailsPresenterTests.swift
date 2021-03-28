//
//  DetailsPresenterTests.swift
//  mobile-coding-challengeTests
//
//  Created by Bruno Augusto Constantino on 3/28/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import XCTest
@testable import mobile_coding_challenge

class DetailsPresenterTests: XCTestCase {
    private let mock = Mock()
    private var presenter: DetailsPresenter = .init(delegate: nil, routerDelegate: nil)
    private var interactor: DetailsInteractor?
    
    override func setUp() {
        super.setUp()
        presenter.setup(arrayImages: [UnsplashModel(id: "1", urls: URLs(thumb: "url1"), links: Link(download: "link1"), user: User(name: "user1"), altDescription: "desc1"), UnsplashModel(id: "2", urls: URLs(thumb: "url2"), links: Link(download: "link2"), user: User(name: "user2"), altDescription: "desc2"), UnsplashModel(id: "3", urls: URLs(thumb: "url3"), links: Link(download: "link3"), user: User(name: "user3"), altDescription: "desc3")], selectedIndex: 1)
        interactor = .init(delegate: mock)
    }
    
    func testGetImageUrl() {
        let expected = mock.getImageUrl()
        let send = presenter.getImageUrl()
        XCTAssertEqual(send, expected)
    }
    
    func testGetImageUserName() {
        let expected = mock.getImageUserName()
        let send = presenter.getImageUserName()
        XCTAssertEqual(send, expected)
    }
    
    func testGetImageDescription() {
        let expected = mock.getImageDescription()
        let send = presenter.getImageDescription()
        XCTAssertEqual(send, expected)
    }
    
    func testAddOneToImage() {
        let send = presenter.addOneToImage()
        XCTAssertTrue(send)
        let send2 = presenter.addOneToImage()
        XCTAssertFalse(send2)
    }
    
    func testSubtractOneToImage() {
        let send = presenter.subtractOneToImage()
        XCTAssertTrue(send)
        let send2 = presenter.subtractOneToImage()
        XCTAssertFalse(send2)
    }
}

// MARK: - Mock

fileprivate class Mock {

    func getImageUrl() -> String {
        return "link2"
    }
    
    func getImageUserName() -> String {
        return "Created by user2"
    }
    
    func getImageDescription() -> String {
        return "desc2"
    }
}

// MARK: - XPCCancelCardInteractorDelegate

extension Mock: DetailsInteractorDelegate {

}
