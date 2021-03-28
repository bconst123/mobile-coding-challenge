//
//  MainPresenterTests.swift
//  mobile-coding-challengeTests
//
//  Created by Bruno Augusto Constantino on 3/28/21.
//  Copyright © 2021 Bruno Augusto Constantino. All rights reserved.
//

import XCTest
@testable import mobile_coding_challenge

class MainPresenterTests: XCTestCase {
    private let mock = Mock()
    private var presenter: MainPresenter = .init(delegate: nil, routerDelegate: nil)
    private var interactor: MainInteractor?
    
    override func setUp() {
        super.setUp()
        interactor = .init(delegate: mock)
    }
    
    func testGetImageArray() {
        presenter.callApi(startAt: 0)
        let expected = mock.getImageArray().count
        let send = presenter.getImageArray().count
        XCTAssertEqual(send, expected)
    }
    
    func testGetViewName() {
        let expected = mock.getViewName()
        let send = presenter.getViewName()
        XCTAssertEqual(send, expected)
    }
}

// MARK: - Mock

fileprivate class Mock {
    private var unsplashModel: [UnsplashModel]?

    func getImageArray() -> [UnsplashModel] {
        return unsplashModel ?? []
    }
    
    func getViewName() -> String {
        return "Photos"
    }
}

// MARK: - XPCCancelCardInteractorDelegate

extension Mock: MainInteractorDelegate {
    
    
    func didLoad(response: [UnsplashModel]) {
        unsplashModel = response
    }
    
    func errorLoading() {
        
    }
}
