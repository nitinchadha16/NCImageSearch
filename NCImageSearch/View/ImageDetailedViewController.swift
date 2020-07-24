//
//  ImageDetailedViewController.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 13/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit
import Lottie
import SDWebImage

class ImageDetailedViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingView: AnimationView!
    @IBOutlet weak var downloadingLoaderView: AnimationView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    var pageIndex: Int = 0
    var dataSource: ImageModel?
    var countText: String!
    
    var showDownloadingLoader: Bool = false {
        didSet {
            downloadingLoaderView.isHidden = !showDownloadingLoader
            showDownloadingLoader ? downloadingLoaderView.play() : downloadingLoaderView.stop()
        }
    }
    
    override func viewDidLoad() {
        
        downloadingLoaderView.animation = Animation.named(Resources.kDownloadingLoader)
        loadingView.animation = Animation.named(Resources.kImageLoader)
        loadingView.loopMode = .loop
        downloadingLoaderView.loopMode = .loop
        
        previewImageView.layer.borderWidth = 1
        previewImageView.layer.borderColor = UIColor.darkGray.cgColor
        
        showDownloadingLoader = false
        countLabel.text = countText
        
        guard let urlString = dataSource?.largeImageURL, let imageUrl = URL(string: urlString) else {
            return
        }
        
        guard let _urlString = dataSource?.previewURL, let previewImageUrl = URL(string: _urlString) else {
            return
        }
        
        loadingView.isHidden = false
        loadingView.play()
        
        previewImageView.sd_setImage(with: previewImageUrl) { [weak self] (image, error, cache, url) in
            self?.previewImageView.image = image
        }
        
        imageView.sd_setImage(with: imageUrl) { [weak self] (image, error, cache, url) in
            self?.loadingView.stop()
            self?.loadingView.isHidden = true
            self?.imageView.image = image
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func newImageListDownloadedCompleted(newCount: Int) {
        showDownloadingLoader = false
        countLabel.text = "\(pageIndex + 1)\\\(newCount)+"
    }
}
