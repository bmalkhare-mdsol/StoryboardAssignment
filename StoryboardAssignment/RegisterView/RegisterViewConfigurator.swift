//
//  RegisterViewConfigurator.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 15/06/23.
//

import Foundation
protocol RegisterViewConfigurator{
    func configure()
}

class RegisterViewConfiguratorImpl: RegisterViewConfigurator {
    var viewController: RegisterViewController
    
    init(viewController: RegisterViewController) {
        self.viewController = viewController
    }
    
    func configure() {
        let router = RegisterViewRouterImpl(viewController: viewController)
        let presenter = RegisterViewPresenterImpl(router: router, view: viewController)
        viewController.presenter = presenter
    }
}
