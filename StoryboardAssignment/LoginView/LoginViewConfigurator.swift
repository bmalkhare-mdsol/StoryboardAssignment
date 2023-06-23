//
//  LoginViewConfigurator.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 22/06/23.
//

import Foundation
protocol LoginViewConfigurator{
    func configure()
}

class LoginViewConfiguratorImpl: LoginViewConfigurator {
    var viewController: LoginViewController
    
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
    
    func configure() {
        let router = LoginViewRouterImpl(viewController: viewController)
        let loginUsecase = LoginUsecaseImpl()
        let presenter = LoginViewPresenterImpl(router: router, view: viewController, usecase: loginUsecase)
        viewController.presenter = presenter
    }
}
