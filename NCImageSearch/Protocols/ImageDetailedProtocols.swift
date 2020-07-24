//
//  ImageDetailedProtocols.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 14/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol ImageDetailedViewToPresenterProtocol: AnyObject {
    var currentIndex: Int { get }
    var imagesCollection: [ImageModel] { get }
    var pagesCount: Int { get }
    func fetchNextPageImages()
}

protocol ImageDetailedPresenterToViewProtocol: AnyObject {
    func imageDownloadingFinished()
}
