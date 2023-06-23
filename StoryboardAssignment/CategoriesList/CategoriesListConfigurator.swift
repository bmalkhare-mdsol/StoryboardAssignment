//
//  CategoriesListConfigurator.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 15/06/23.
//

import Foundation
protocol CategoriesListConfigurator{
    func configure(person: Person)
}

class CategoriesListConfiguratorImpl: CategoriesListConfigurator {
    var viewController: CategoriesListController
    
    init(viewController: CategoriesListController) {
        self.viewController = viewController
    }
    
    func configure(person: Person) {
        let router = CategoriesListRouterImpl(viewController: viewController)
        let usecase = CategoryDetailsUseCaseImpl()
        let presenter = CategoriesListPresenterImpl(router: router, usecase: usecase, person: person,view: viewController)
        viewController.presenter = presenter
    }
}
