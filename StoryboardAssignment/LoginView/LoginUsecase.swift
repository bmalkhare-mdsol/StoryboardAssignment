//
//  LoginUsecase.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 22/06/23.
//

import Foundation
protocol LoginUsecase {
    func getPersonFromDB(username: String, password: String) -> Person?
}

class LoginUsecaseImpl: LoginUsecase {
    let dbHelper = DBHelper()
   
    func getPersonFromDB(username: String, password: String) -> Person? {
        let persons = dbHelper.read()
        if let person = persons.filter({$0.name == username && $0.password == password}).first {
            return person
        }
        return nil
    }
   
}
