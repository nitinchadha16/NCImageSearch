//
//  ImageListPresenter.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 12/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

class ImageListPresenter: NSObject {
    
    var pageNumber: Int
    var pageLimit: Int
    var imagesList: [ImageModel] = []
    var searchString: String!
    
    weak var view: ImageListPresenterToViewProtocol!
    var interactor: ImageListPresenterToInteractorProtocol!
    
    override init() {
        pageNumber = 1
        pageLimit = NetworkConstants.kPageLimit
    }
}

extension ImageListPresenter: ImageListViewToPresenterProtocol {
    func fetchImageListForNextPage(searchString: String) {
        view.showLoader()
        pageNumber += 1;
        self.searchString = searchString
        interactor.fetchImageList(searchString: searchString, pageNumber: pageNumber, pageLimit: pageLimit)
    }
    
    func fetchImageListForNewSearch(searchString: String) {
        pageNumber = 1
        imagesList.removeAll()
        view.showLoader()
        self.searchString = searchString
        interactor.fetchImageList(searchString: searchString, pageNumber: pageNumber, pageLimit: pageLimit)
    }
    
    func navigateToImageDetailedScreen(index: Int){
        ApplicationRouter.shared.navigateToImageDetailedScreen(dataSource: imagesList, index: index, page: pageNumber, search: searchString)
    }
}

extension ImageListPresenter: ImageListInteractorToPresenterProtocol {
    func fetchImageListSuccess(collection images: [ImageModel]) {
        imagesList += images
        DispatchQueue.main.async {
            self.view.hideLoader()
            self.view.reloadCollection()
        }
    }
    
    func fetchImageListFailure(errorText: String?) {
        DispatchQueue.main.async {
            self.view.hideLoader()
            self.view.showError(errorString: errorText)
        }
    }
}
