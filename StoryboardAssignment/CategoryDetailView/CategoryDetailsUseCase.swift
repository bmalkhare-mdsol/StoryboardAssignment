//
//  CategoryDetailsUseCase.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 20/06/23.
//

import Foundation
protocol CategoryDetailsUseCase{
    func getCategoryDetailsList() -> CategoryDetailModel?
    func saveCategoryModelInDB(category: CategoryDetailModel, person: Person)
    func getCategoryModel(person: Person, category: Category) -> Category?
    func getCategoryModelForPerson(person: Person) -> CategoryDetailModel? 
}
class CategoryDetailsUseCaseImpl: CategoryDetailsUseCase {
    let dbHelper = DBHelper()
    func getCategoryDetailsList() -> CategoryDetailModel? {
        if let url =  Bundle.main.url(forResource: "Category", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CategoryDetailModel.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func saveCategoryModelInDB(category: CategoryDetailModel, person: Person) {
        do {
            let jsonData = try JSONEncoder().encode(category)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            person.categoryListJson = jsonString
            dbHelper.update(person: person, categoryJSON: jsonString)
        } catch {}
    }
    func getCategoryModel(person: Person, category: Category) -> Category? {
        let persons = dbHelper.read()
        var personCategoryModel: CategoryDetailModel?
        if let currentPerson = persons.filter({$0.name == person.name}).first {
            do {
                personCategoryModel = try JSONDecoder().decode(CategoryDetailModel.self, from: currentPerson.categoryListJson.data(using: .utf8)!)
            } catch {}
        }
        if let model = personCategoryModel {
            return model.categories.filter({$0.name == category.name}).first
        }
        return nil
    }
    func getCategoryModelForPerson(person: Person) -> CategoryDetailModel? {
        let persons = dbHelper.read()
        var personCategoryModel: CategoryDetailModel?
        if let currentPerson = persons.filter({$0.name == person.name}).first {
            do {
                personCategoryModel = try JSONDecoder().decode(CategoryDetailModel.self, from: currentPerson.categoryListJson.data(using: .utf8)!)
            } catch {}
        }
       
        return personCategoryModel
    }
}
