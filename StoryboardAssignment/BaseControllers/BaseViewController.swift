//
//  BaseViewController.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 21/06/23.
//

import Foundation
import UIKit
class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuButton = UIButton()
        menuButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        menuButton.addTarget(self, action: #selector(leftClicked), for:    .touchUpInside)
        var background = UIImageView(image: UIImage(named: "back"))
        background.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        menuButton.addSubview(background)

        let menuBarButtonItem = UIBarButtonItem(customView: menuButton)
        navigationItem.leftBarButtonItems = [menuBarButtonItem]
    }
    
    @objc func leftClicked() {
        self.leftTapped()
    }
    @objc func leftTapped() {
        
    }
}
