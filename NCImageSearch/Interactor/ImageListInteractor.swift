//
//  ImageListInteractor.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 14/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

class ImageListInteractor: NSObject, ImageListPresenterToInteractorProtocol {
    
    weak var presenter: ImageListInteractorToPresenterProtocol!
    
    func fetchImageList(searchString: String, pageNumber: Int, pageLimit: Int) {
        
        let request = URLBuilder(searchString: searchString, pageNumber: pageNumber, pageLimit: pageLimit)
        
        if let url = request.fetchRequestURL() {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard let data = data else { return }
                
                do {
                    let obj: ImageURLListModel = try JSONDecoder().decode(ImageURLListModel.self, from: data)
                    
                    if obj.imageCollection.count > 0 {
                        self.presenter.fetchImageListSuccess(collection: obj.imageCollection)
                    } else {
                        self.presenter.fetchImageListFailure(errorText: StringConstants.kNoImageFoundText)
                    }
                } catch {
                    self.presenter.fetchImageListFailure(errorText: StringConstants.kImageFetchFailText)
                }
            }.resume()
        }
    }
}
