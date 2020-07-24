//
//  ImageListViewController.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 11/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit
import SDWebImage
import Lottie


class ImageListViewController: UIViewController {

    var presenter: ImageListViewToPresenterProtocol!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingView: AnimationView!
    let searchBar = UISearchBar(frame: CGRect.zero)
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
    }
    
    func configUserInterface() {
        searchBar.placeholder = StringConstants.kSearch
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        loadingView.animation = Animation.named(Resources.kDownloadingLoader)
        loadingView.loopMode = .loop
        loadingView.isHidden = true
        
        errorLabel.text = StringConstants.kNoImagesText
        errorLabel.isHidden = false
        navigationController?.navigationBar.barTintColor = ColorConstants.primary
    }
}


//MARK: CONFORMANCE OF UICollectionViewDelegateFlowLayout UICollectionViewDelegateFlowLayout PROTOCOL
extension ImageListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .kCellIdentifier, for: indexPath) as! ImageCollectionViewCell
        let imageModal = presenter.imagesList[indexPath.row]
        cell.nameLabel.text = imageModal.tags
        cell.errorLabel.isHidden = true
        cell.isLoading = true
        
        if let url = URL(string: imageModal.webformatURL) {
            cell.imageView.sd_setImage(with: url) { (image, error, cacheType, url) in
                cell.isLoading = false
                cell.imageView.image = image
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.imagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSide = (Int(collectionView.frame.width) - 10)/2
        return CGSize(width: cellSide,height: cellSide)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        
        if indexPath.row == presenter.imagesList.count - 1 {
            presenter.fetchImageListForNextPage(searchString: searchBar.text ?? .kEmpty)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.navigateToImageDetailedScreen(index: indexPath.row)
    }
}


//MARK: CONFORMANCE OF UISearchBarDelegate PROTOCOL
extension ImageListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchString = searchBar.text else {
            return
        }
        
        errorLabel.isHidden = true
        presenter.fetchImageListForNewSearch(searchString: searchString.condenseWhitespace())
        searchBar.resignFirstResponder()
    }
}

//MARK: CONFORMANCE OF ImageListPresenterToView PROTOCOL
extension ImageListViewController: ImageListPresenterToViewProtocol {
    func showLoader() {
        loadingView.play()
        loadingView.isHidden = false
    }
    
    func hideLoader() {
        loadingView.stop()
        loadingView.isHidden = true
    }
    
    func reloadCollection() {
        errorLabel.isHidden = true
        self.collectionView.reloadData()
    }
    
    func showError(errorString: String?) {
        errorLabel.text = errorString ?? StringConstants.kNoImagesText
        errorLabel.isHidden = false
    }
}

