//
//  SignUpPresenter.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 14/06/23.
//

import Foundation

protocol SignUpPresenter {
    func registerPressed()
    func loginPressed()
}

class SignUpPresenterImpl: SignUpPresenter {
    
    var router: SignUpRouter
    
    init(router: SignUpRouter) {
        self.router = router
    }
    
    func registerPressed() {
        router.navigateToRegisterScreen()
    }
    
    func loginPressed() {
        router.navigateToLoginScreen()
    }
}
