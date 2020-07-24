//
//  ApplicationRouter.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 11/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

class ApplicationRouter {
    
    static let shared = ApplicationRouter()
    
    var storyboard: UIStoryboard {
        return UIStoryboard(name: StoryboardConstants.kDashboard, bundle: nil)
    }
    
    var navigationController: UINavigationController!
    
    private init() {}
    
    func initializeWorkflow() -> UIViewController {
        
        guard let view: ImageListViewController = storyboard.getViewController() else {
            return UIViewController()
        }
        
        let presenter = ImageListPresenter()
        let interactor = ImageListInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    
    func navigateToImageDetailedScreen(dataSource: [ImageModel], index: Int, page: Int, search: String) {
        
        guard let view: ImageDetailedViewContainer = storyboard.getViewController() else {
            return
        }
        
        guard let presenter = ImageDetailedContainerPresenter(imagesCollection: dataSource,
                                                              currentIndex: index,
                                                              pageNumber: page,
                                                              searchString: search) else {
            return
        }
        
        let interactor = ImageListInteractor()
        presenter.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
    
    
}
