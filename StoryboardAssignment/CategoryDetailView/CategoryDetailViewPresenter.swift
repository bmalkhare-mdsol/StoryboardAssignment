//
//  CategoryDetailViewPresenter.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 19/06/23.
//

import Foundation
import UIKit
import PDFKit

enum WithExtension: String {
    case mp4
    case pdf
}

protocol CategoryDetailPresenter {
    func numberOfRows(in section: Int) -> Int
    func getCategoryDetailModel(index: IndexPath) -> CategoryItem? 
    func numberOfSection() -> Int
    func getNavigationHeaderTitle() -> String
    func updateCategoryDetailModel(index: IndexPath)
    func viewWillAppear()
}

protocol CategoryDetailView{
    func reloadTable()
}

class CategoryDetailPresenterImpl: CategoryDetailPresenter {
    var view: CategoryDetailView
    var router: CategoryDetailRouter
    var usecase: CategoryDetailsUseCase
    var category: Category
    var person: Person
    var model: CategoryDetailModel?
    init(router: CategoryDetailRouter, usecase: CategoryDetailsUseCase, category: Category, person: Person, view: CategoryDetailView, model: CategoryDetailModel?) {
        self.router = router
        self.usecase = usecase
        self.category = category
        self.person = person
        self.view = view
        self.model = model
    }
    
    func getCategoryDetailModel(index: IndexPath) -> CategoryItem? {
        if let type = CategoryType.getCategoryType(index: index.section)
         {
            switch type {
            case .image:
                return self.category.imagesList[index.row]
            case .video:
                return self.category.videoList[index.row]
            case .pdf:
                return self.category.pdfList[index.row]
            }
        }
        return nil
    }
    
    
    func updateCategoryDetailModel(index: IndexPath) {
        if let type = CategoryType.getCategoryType(index: index.section)
         {
            switch type {
            case .image:
                self.category.imagesList[index.row].isVisited = true
            case .video:
                 self.category.videoList[index.row].isVisited = true
            case .pdf:
                 self.category.pdfList[index.row].isVisited = true
            }
        }
        if let index = self.model?.categories.firstIndex(where: {$0.name == category.name}) {
            model?.categories[index] = self.category
            guard let model = model else { return }
            usecase.saveCategoryModelInDB(category: model, person: person)
        }
    }
    
    func viewWillAppear(){

        if let category = usecase.getCategoryModel(person: person, category: category){
            self.category = category
        }
        self.view.reloadTable()
    }
    
    
    func getNavigationHeaderTitle() -> String {
       return self.category.name
    }

    
    func numberOfSection() -> Int {
        return CategoryType.allCases.count
    }

    func numberOfRows(in section: Int) -> Int {
       if let type = CategoryType.getCategoryType(index: section)
        {
           switch type {
           case .image:
               return self.category.imagesList.count
           case .video:
               return self.category.videoList.count
           case .pdf:
               return self.category.pdfList.count

           }
       }
        return 0
    }
    
}



