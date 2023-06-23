//
//  ViewController.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 14/06/23.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    var configurator:  SignUpConfigurator?
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    var presenter: SignUpPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator =  SignUpConfiguratorImpl(viewController: self)
        configurator?.configure()
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        presenter.registerPressed()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        presenter.loginPressed()
    }
    
}

