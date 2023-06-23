//
//  CategoriesListRouter.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 15/06/23.
//

import Foundation
import UIKit
protocol CategoriesListRouter {
    func navigateToCategoryDetailScreen(selectedCategory: Category,person: Person, model: CategoryDetailModel?)
}


class CategoriesListRouterImpl: CategoriesListRouter {
    
    var viewController: CategoriesListController
    
    init(viewController: CategoriesListController) {
        self.viewController = viewController
    }
    
    func navigateToCategoryDetailScreen(selectedCategory: Category, person: Person, model: CategoryDetailModel?) {
        let vc =  CommonUtility.getViewController(storyboardName: StoryBordIds.main, bundleID: StoryBordIds.categoryDetailViewController) as? CategoryDetailViewController
        let configurator = CategoryDetailViewConfiguratorImpl(viewController: vc!)
        configurator.configure(selectedCategory: selectedCategory, person: person, model: model)
        vc?.configurator = configurator
        self.viewController.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
