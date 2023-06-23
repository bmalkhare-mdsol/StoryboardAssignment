//
//  CategoryDetailViewRouter.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 19/06/23.
//

import Foundation
import UIKit
protocol CategoryDetailRouter {}


class CategoryDetailRouterImpl: CategoryDetailRouter {
    
    var viewController: CategoryDetailViewController
    
    init(viewController: CategoryDetailViewController) {
        self.viewController = viewController
    }

}
