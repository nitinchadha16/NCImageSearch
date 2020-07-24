//
//  Constants.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 11/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

struct StoryboardConstants {
    static let kDashboard = "Dashboard"
}

struct StringConstants {
    static let kSearch = "Search"
    static let kNoImagesText = "No Photos Available"
    static let kNoImageFoundText = "No images found !!"
    static let kImageFetchFailText = "OOPS !! Something went wrong"
}

struct ColorConstants {
    static let primary = UIColor(red: 0.66, green: 0.85, blue: 0.86, alpha: 1.00)
}

struct Resources {
    static let kDownloadingLoader = "loader"
    static let kImageLoader = "image_loader"
}

struct NetworkConstants {
    static let kPageLimit = 10
}

extension String {
    static let kEmpty = ""
    static let kCellIdentifier = "CELL"
}


