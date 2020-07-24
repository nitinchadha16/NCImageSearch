//
//  ImageCollectionViewCell.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 12/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit
import Lottie


class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loadingView: AnimationView!
    
    var isLoading: Bool = true {
        didSet {
            loadingView.isHidden = !self.isLoading
            self.isLoading ? loadingView.play() : loadingView.stop()
        }
    }
    
    override func awakeFromNib() {
        loadingView.animation = Animation.named(Resources.kImageLoader)
        loadingView.loopMode = .loop
        loadingView.isHidden = false
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
}
