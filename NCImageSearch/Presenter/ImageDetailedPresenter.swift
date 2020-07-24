//
//  ImageDetailedPresenter.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 14/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

class ImageDetailedContainerPresenter: NSObject, ImageDetailedViewToPresenterProtocol {
    
    weak var view: ImageDetailedPresenterToViewProtocol!
    var interactor: ImageListPresenterToInteractorProtocol!
    
    var imagesCollection: [ImageModel]
    var currentIndex: Int
    var apiPageNumber: Int
    var searchString: String
    
    var pagesCount: Int {
        return imagesCollection.count
    }
    
    init?(imagesCollection: [ImageModel], currentIndex: Int, pageNumber: Int, searchString: String) {
        guard currentIndex >= 0, !imagesCollection.isEmpty else {
            return nil
        }
        
        self.imagesCollection = imagesCollection
        self.currentIndex = currentIndex
        self.apiPageNumber = pageNumber
        self.searchString = searchString
    }
    
    func fetchNextPageImages() {
        apiPageNumber += 1
        interactor.fetchImageList(searchString: searchString, pageNumber: apiPageNumber, pageLimit: NetworkConstants.kPageLimit)
    }
}

extension ImageDetailedContainerPresenter: ImageListInteractorToPresenterProtocol {
    func fetchImageListSuccess(collection: [ImageModel]) {
        imagesCollection += collection
        DispatchQueue.main.async {
            self.view.imageDownloadingFinished()
        }
    }
    
    func fetchImageListFailure(errorText: String?) {
        DispatchQueue.main.async {
            self.view.imageDownloadingFinished()
        }
    }
}
