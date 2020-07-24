//
//  URLBuilder.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 14/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

struct URLBuilder {
    
    var searchString: String
    var pageNumber: Int
    var pageLimit: Int
    
    init(searchString: String, pageNumber: Int, pageLimit: Int ) {
        self.searchString = searchString
        self.pageNumber = pageNumber
        self.pageLimit = pageLimit
    }
    
    func fetchRequestURL() -> URL? {
        if let url = URL(string: "https://pixabay.com/api/?key=16998714-26928b41be7d07353929c8bd0&q=\(searchString)&image_type=photo&page=\(pageNumber)&per_page=\(pageLimit)") {
            return url
        } else {
            return nil
        }
    }
}
