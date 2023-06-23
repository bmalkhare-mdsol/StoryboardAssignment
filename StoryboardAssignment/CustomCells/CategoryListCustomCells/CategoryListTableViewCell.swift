//
//  CategoryListTableViewCell.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 16/06/23.
//

import UIKit

struct CategoryListModel {
    var categoryName: String
    var iconName: String
}


class CategoryListTableViewCell: UITableViewCell {
    static var identifier = "CategoryListTableViewCell"
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        outerView.layer.borderWidth = 0.5
        outerView.layer.borderColor = UIColor.lightGray.cgColor
        outerView.layer.cornerRadius = 8
    }

    func configureCell(model: Category, isVisited: Bool) {
        outerView.backgroundColor = isVisited ? .clear : Colors.lightGray.uiColor
        categoryNameLabel.text = model.name
        iconImageView.image = UIImage(named: model.iconName)
    }
    
    func configure(model: CategoryItem?) {
        guard let model = model else {
            return
        }
        categoryNameLabel.text = model.name
        iconImageView.isHidden = true
        outerView.backgroundColor = model.isVisited ? .clear : Colors.lightGray.uiColor
    }
    
}
