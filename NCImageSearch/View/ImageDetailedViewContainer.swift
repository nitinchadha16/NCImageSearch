//
//  ImageDetailedViewContainer.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 14/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

class ImageDetailedViewContainer: UIPageViewController {

    var presenter: ImageDetailedViewToPresenterProtocol!
    weak var currentViewController: ImageDetailedViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let firstVC = self.getViewController(withIndex: presenter.currentIndex) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension ImageDetailedViewContainer: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageIndex = (viewController as? ImageDetailedViewController)?.pageIndex ?? 0
        
        if pageIndex == 0 {
            return nil
        }
        
        pageIndex = pageIndex - 1
        return self.getViewController(withIndex: pageIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageIndex = (viewController as? ImageDetailedViewController)?.pageIndex ?? presenter.pagesCount - 1
        
        if pageIndex == presenter.pagesCount - 1 {
            currentViewController = (viewController as? ImageDetailedViewController)
            currentViewController?.showDownloadingLoader = true
            presenter.fetchNextPageImages()
            return nil
        }
        
        pageIndex = pageIndex + 1
        return self.getViewController(withIndex: pageIndex)
    }
    
    fileprivate func getViewController(withIndex:Int) -> UIViewController? {
        if let contentViewController: ImageDetailedViewController =  self.storyboard?.getViewController() {
            contentViewController.dataSource = presenter.imagesCollection[withIndex]
            contentViewController.pageIndex = withIndex
            contentViewController.countText = "\(withIndex + 1)\\\(presenter.imagesCollection.count)+"
            return contentViewController
        }
        return nil
    }
}

extension ImageDetailedViewContainer: ImageDetailedPresenterToViewProtocol {
    func imageDownloadingFinished() {
        currentViewController?.newImageListDownloadedCompleted(newCount: presenter.imagesCollection.count)
        currentViewController = nil
    }
}
