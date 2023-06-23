//
//  CategoryDetailModel.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 20/06/23.
//

import Foundation

struct CategoryDetailModel: Codable {
    var categories: [Category] = []
    
    
}

struct Category: Codable{
    var name: String = ""
    var iconName: String = ""
    var pdfList: [CategoryItem] = []
    var imagesList: [CategoryItem] = []
    var videoList: [CategoryItem] = []
    
    var isPDFVisited: Bool {
        return pdfList.filter({ $0.isVisited}).count == pdfList.count
    }
    var isImagesVisited: Bool {
        return imagesList.filter({ $0.isVisited}).count == imagesList.count
    }
    var isVideoVisited: Bool {
        return videoList.filter({ $0.isVisited}).count == videoList.count
    }
    
    var allElementsVisited: Bool{
        return isPDFVisited && isImagesVisited && isVideoVisited
    }
    
}

struct CategoryItem: Codable{
    var id: String
    var type: String
    var name: String
    var category_slug: String
    var isVisited: Bool = false
    var categoryType: CategoryType {
        return CategoryType(rawValue: type) ?? .image
    }
}

enum CategoryType: String, CaseIterable{
    case pdf
    case video
    case image
    func getIndex() -> Int {
        switch self {
        case .pdf:
            return 0
        case .video:
            return 1
        case .image:
            return 2
        
        }
    }
   static func getCategoryType(index: Int) -> CategoryType? {
        switch index {
        case 0:
            return .pdf
        case 1:
            return .video
        case 2:
            return .image
        default:
            return nil
        }
    }
    func getCategoryNames() -> String {
        switch self {
        case .pdf:
            return "PDF"
        case .video:
            return "Videos"
        case .image:
            return "Images"
        
        }
    }
}
