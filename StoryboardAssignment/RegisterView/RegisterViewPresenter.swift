//
//  RegisterViewPresenter.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 14/06/23.
//

import Foundation


struct RegisterDataModel {
    var name: String
    var password: String
    var gender: Gender
    var birthDate: String
}
protocol RegisterDataView {
    func showToast(text: String)
    func reloadTable(type: RegisterViewItem)
    func showAlert(text: String)
}

enum Gender: CaseIterable {
    case male
    case female
    
    func getTitle() -> String {
        switch self {
        case .male:
            return RegisterViewConstants.male.rawValue
        case .female:
            return RegisterViewConstants.female.rawValue
        }
    }
}



enum RegisterViewConstants: String{
    case login = "Log In"
    case signUp = "Sign Up"
    case name = "Enter Username"
    case password = "Enter Password"
    case confirmPassword = "Confirm Password"
    case gender = "Select Gender"
    case birthDate = "Select BirthDate"
    case selectDate = "Select Date"
    case male = "Male"
    case female = "Female"
    case ok = "Select"
    case cancel = "Cancel"
    case enter = "Enter All Mandatory Information"
    case passwordNotMatching = "Passwords are not matching"
    case usernameExist = "Username is already exist, Please add new one."

}

enum RegisterViewItem: Int,CaseIterable {
    case name = 0
    case password
    case confirmPassword
    case gender
    case birthDate
    
    func getPlaceholder() -> String {
        switch self {
        case .name:
            return RegisterViewConstants.name.rawValue
        case .password:
            return RegisterViewConstants.password.rawValue
        case .confirmPassword:
            return RegisterViewConstants.confirmPassword.rawValue
        case .gender:
            return RegisterViewConstants.gender.rawValue
        case .birthDate:
            return RegisterViewConstants.birthDate.rawValue
        }
    }
}


protocol RegisterViewPresenter {
    func signInTapped()
    func updateGender(gender: Gender)
    func updatePassword(text: String)
    func updateConfirmPassword(text: String)
    func updateUserName(text: String)
    func updateBirthDate(text: String)
    var person: Person? { get }
}


class RegisterViewPresenterImpl: RegisterViewPresenter {
   
    var view: RegisterDataView?
    var person: Person?
    var router: RegisterViewRouter
    var db:DBHelper
    init(router: RegisterViewRouter, view: RegisterDataView?) {
        self.router = router
        self.view = view
        person = Person(name: "", password: "", gender: "", birthDate: "")
        db = DBHelper()
    }
    
    func insertDataInDB(){
        guard let person = person  else { return}
        if isValidInfo() {
            if db.isUserAlreadyExist(name: person.name) {
                self.view?.showAlert(text: RegisterViewConstants.usernameExist.rawValue)
                return
            }
            
            db.insert(name: person.name, password: person.password, gender: person.gender, birthDate: person.birthDate)
            let persons = db.read()
            print(persons)
            router.navigateTocategoriesListScreen(person: person)
        }
    }
    
    func updateGender(gender: Gender) {
        person?.gender = gender.getTitle()
        self.view?.reloadTable(type: .gender)
    }
    
    func signInTapped() {
        if isValidInfo() {
            insertDataInDB()
        }
    }
    
    func updatePassword(text: String) {
        person?.password = text
    }
    
    func updateConfirmPassword(text: String) {
        person?.confirmPassword = text

    }
    
    func updateUserName(text: String) {
        person?.name = text
    }
    
    func updateBirthDate(text: String) {
        person?.birthDate = text
        self.view?.reloadTable(type: .birthDate)
    }

    
    func isValidInfo() -> Bool {
        guard let person = person else {
            self.view?.showToast(text: RegisterViewConstants.enter.rawValue)
            return false
        }
        if person.name.isEmpty || person.gender.isEmpty || person.birthDate.isEmpty {
            self.view?.showToast(text: RegisterViewConstants.enter.rawValue)
            return false
        }
        if person.password != person.confirmPassword {
            self.view?.showToast(text: RegisterViewConstants.passwordNotMatching.rawValue)
            return false
        }
        return true
    }
}
