//
//  DashboardViewRouter.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 14/06/23.
//

import Foundation
import UIKit
protocol SignUpRouter {
    func navigateToRegisterScreen()
    func navigateToLoginScreen()
}

class SignUpRouterImpl: SignUpRouter {
    
    var viewController: ViewController
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func navigateToRegisterScreen() {
        let vc =  CommonUtility.getViewController(storyboardName: StoryBordIds.main, bundleID: StoryBordIds.registerViewController) as? RegisterViewController
        self.viewController.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func navigateToLoginScreen() {
        let vc =  CommonUtility.getViewController(storyboardName: StoryBordIds.main, bundleID: StoryBordIds.loginViewController) as? LoginViewController
        self.viewController.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
