//
//  LoginViewPresenter.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 22/06/23.
//

import Foundation

enum LoginViewConstant: String{
    case enterUsername = "Please Enter Username"
    case enterPassword = "Please Enter Password"
    case invalidUser = "Invalid Username Or Password"
}

protocol LoginViewPresenter {
    func loginTapped(username: String, password: String)
}
protocol LoginView {
    func showToast(text: String)
    func showAlert(text: String)
}

class LoginViewPresenterImpl: LoginViewPresenter {
   
    var view: LoginView?
    var person: Person?
    var router: LoginViewRouter
    var usecase: LoginUsecase
    init(router: LoginViewRouter, view: LoginView?, usecase: LoginUsecase) {
        self.router = router
        self.view = view
        self.usecase = usecase
    }
    func loginTapped(username: String, password: String) {
        if let person = usecase.getPersonFromDB(username: username, password: password) {
            router.navigateTocategoriesListScreen(person: person)
            return
        }
        self.view?.showAlert(text: LoginViewConstant.invalidUser.rawValue)
    }

    
}
