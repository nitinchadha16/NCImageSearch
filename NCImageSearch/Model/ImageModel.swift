//
//  ImageModel.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 14/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

struct ImageURLListModel: Codable {
    let imageCollection: [ImageModel]
    
    private enum CodingKeys : String, CodingKey {
        case imageCollection = "hits"
    }
}

// MARK: - ImageModel
struct ImageModel: Codable {
    let id: Int
    let type, tags: String
    let previewURL: String
    let webformatURL: String
    let largeImageURL: String
}
