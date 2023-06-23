//
//  CommonUtilityClass.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 15/06/23.
//

import Foundation
import UIKit

struct StoryBordIds{
    static var main = "Main"
    static var registerViewController = "RegisterViewController"
    static var categoriesListController = "CategoriesListController"
    static var categoryDetailViewController = "CategoryDetailViewController"
    static var imageViewController = "ImageViewController"
    static var loginViewController = "LoginViewController"
}


class CommonUtility{
   public static func getViewController(storyboardName: String, bundleID: String)  -> UIViewController? {
        return UIStoryboard.init(name: storyboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: bundleID)
    }
}
