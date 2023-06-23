//
//  CategoryDetailViewConfigurator.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 19/06/23.
//

import Foundation
protocol CategoryDetailViewConfigurator {
    func configure(selectedCategory: Category, person: Person, model: CategoryDetailModel?)
}

class CategoryDetailViewConfiguratorImpl: CategoryDetailViewConfigurator {
    var viewController: CategoryDetailViewController
    
    init(viewController: CategoryDetailViewController) {
        self.viewController = viewController
    }
    
    func configure(selectedCategory: Category, person: Person, model: CategoryDetailModel?) {
        let router = CategoryDetailRouterImpl(viewController: viewController)
        let usecase  = CategoryDetailsUseCaseImpl()
        let presenter = CategoryDetailPresenterImpl(router: router,usecase: usecase, category: selectedCategory, person: person, view: viewController, model: model)
        viewController.presenter = presenter
    }
}
