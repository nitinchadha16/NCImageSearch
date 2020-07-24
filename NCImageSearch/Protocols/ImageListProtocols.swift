//
//  ImageListProtocols.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 14/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol ImageListViewToPresenterProtocol: AnyObject {
    var imagesList: [ImageModel] { get }
    func fetchImageListForNewSearch(searchString: String)
    func fetchImageListForNextPage(searchString: String)
    func navigateToImageDetailedScreen(index: Int)
}

protocol ImageListPresenterToViewProtocol: AnyObject {
    func showLoader()
    func hideLoader()
    func reloadCollection()
    func showError(errorString: String?)
}

protocol ImageListInteractorToPresenterProtocol: AnyObject {
    func fetchImageListSuccess(collection: [ImageModel])
    func fetchImageListFailure(errorText: String?)
}

protocol ImageListPresenterToInteractorProtocol: AnyObject {
    func fetchImageList(searchString: String, pageNumber: Int, pageLimit: Int)
}

protocol ImageListPresenterToRouterProtocol: AnyObject {
    func navigateToImageDetailedScreen(index: Int) -> UIViewController?
}

