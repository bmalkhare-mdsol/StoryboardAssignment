//
//  RegisterViewRouter.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 14/06/23.
//


import Foundation
import UIKit
protocol RegisterViewRouter {
    func navigateTocategoriesListScreen(person: Person)
}


class RegisterViewRouterImpl: RegisterViewRouter {
    
    var viewController: RegisterViewController
    
    init(viewController: RegisterViewController) {
        self.viewController = viewController
    }

    func navigateTocategoriesListScreen(person: Person) {
        let vc =  CommonUtility.getViewController(storyboardName: StoryBordIds.main, bundleID: StoryBordIds.categoriesListController) as? CategoriesListController
        
        let configurator = CategoriesListConfiguratorImpl(viewController: vc!)
        configurator.configure(person: person)

        vc?.configurator = configurator
        self.viewController.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
