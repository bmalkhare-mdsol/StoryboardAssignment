//
//   SignUpConfigurator.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 14/06/23.
//

import Foundation
protocol  SignUpConfigurator{
    func configure()
}

class SignUpConfiguratorImpl:  SignUpConfigurator {
    var viewController: ViewController
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func configure() {
        let router = SignUpRouterImpl(viewController: viewController)
        let presenter = SignUpPresenterImpl(router: router)
        viewController.presenter = presenter
    }
}
