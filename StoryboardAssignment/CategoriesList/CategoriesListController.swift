//
//  CategoriesListController.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 15/06/23.
//

import UIKit
import SQLite3
import UserNotifications

class CategoriesListController: UIViewController {
    
    @IBOutlet weak var categoryListTable: UITableView!
    var configurator: CategoriesListConfigurator?
    var presenter: CategoriesListPresenter!
    var isAllVisitedCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryListTable.register(UINib(nibName: CategoryListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryListTableViewCell.identifier)
        categoryListTable.separatorStyle = .none
        self.navigationItem.title = presenter.getNavigationHeaderTitle()
        UNUserNotificationCenter.current().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
        
    }
    
}
extension CategoriesListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  !presenter.isCellInteractive(index: indexPath) {
            self.showAlert(message: CategoriesListConstant.visitPrevSection.rawValue)
            return
        }
        presenter.cellTapped(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let category = presenter.getCategory(row: indexPath.row) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryListTableViewCell.identifier) as! CategoryListTableViewCell
            cell.configureCell(model: category, isVisited: presenter.isCellInteractive(index: indexPath))
            cell.selectionStyle = .none
            if presenter.isAllCellsVisited && self.isAllVisitedCount == 0{
                  isAllVisitedCount += 1
                  LocatNotification.shared.sendNotification()
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension CategoriesListController: CategoriesListView {
    func reloadTable() {
        self.categoryListTable.reloadData()
    }
}

extension CategoriesListController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .badge])
    }

}
