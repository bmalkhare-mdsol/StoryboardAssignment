//
//  CategoriesListPresenter.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 15/06/23.
//

import Foundation

enum CategoriesListConstant: String {
    case visitPrevSection = "Please complete all the previous section visit first"
}

protocol CategoriesListPresenter {
    func cellTapped(index: Int)
    func numberOfRows() -> Int
    func getCategory(row: Int) -> Category?
    func getNavigationHeaderTitle() -> String
    func viewWillAppear()
    func isCellInteractive(index: IndexPath) -> Bool
    var isAllCellsVisited: Bool {get}
    
}
protocol CategoriesListView {
    func reloadTable()
}
class CategoriesListPresenterImpl: CategoriesListPresenter {
    
    var router: CategoriesListRouter
    var usecase: CategoryDetailsUseCase
    var model: CategoryDetailModel?
    var person: Person
    var view:CategoriesListView
    var isAllCellsVisited: Bool = false
    
    init(router: CategoriesListRouter, usecase: CategoryDetailsUseCase, person: Person, view:CategoriesListView) {
        self.router = router
        self.usecase = usecase
        model = self.usecase.getCategoryDetailsList()
        self.person = person
        self.view = view
    }
    
    func getNavigationHeaderTitle() -> String {
        return person.name
    }
    
    func viewWillAppear() {
        getCategory()
    }
    
    func isCellInteractive(index: IndexPath) -> Bool {
        guard let categoriesList = model?.categories else {return false}
        let count = categoriesList.filter({$0.allElementsVisited}).count
        if count == categoriesList.count {
            self.isAllCellsVisited = true
        }
        if count == index.row || index.row < count {
            return true
        }
        
        return false
    }
    
    func getCategory() {
        if let categoryModel = usecase.getCategoryModelForPerson(person: person) {
            self.model = categoryModel
            self.view.reloadTable()
        }
    }
    
    func getCategory(row: Int) -> Category? {
        return model?.categories[row] ?? nil
    }
    
    func numberOfRows() -> Int {
        return model?.categories.count ?? 0
    }
    
    func cellTapped(index: Int) {
        if let category = model?.categories[index] {
            router.navigateToCategoryDetailScreen(selectedCategory: category, person: person, model: model)
        }
    }
}
