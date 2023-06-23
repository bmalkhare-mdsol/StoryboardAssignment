//
//  LoginViewRouter.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 22/06/23.
//

import Foundation
import UIKit
protocol LoginViewRouter {
    func navigateTocategoriesListScreen(person: Person)
}

class LoginViewRouterImpl: LoginViewRouter {
    var viewController: LoginViewController
    init(viewController: LoginViewController) {
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
