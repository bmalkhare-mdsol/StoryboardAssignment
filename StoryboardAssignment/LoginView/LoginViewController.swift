//
//  LoginViewController.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 22/06/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var configurator: LoginViewConfigurator?
    var presenter: LoginViewPresenter!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        usernameTextField.disableAutoFill()
        passwordTextField.disableAutoFill()

        configurator = LoginViewConfiguratorImpl(viewController: self)
        configurator?.configure()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        self.navigationItem.title = RegisterViewConstants.login.rawValue
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func eyeIconTapped(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text else {
            self.showToast(text: LoginViewConstant.enterUsername.rawValue)
            return
        }
        guard let password = passwordTextField.text else {
            self.showToast(text: LoginViewConstant.enterPassword.rawValue)
            return
        }
        presenter.loginTapped(username: username, password: password)
    }
    
}

extension LoginViewController:  LoginView {
    
    func showToast(text: String) {
        self.showToastMessage(message: text)
    }
    func showAlert(text: String) {
        self.showAlert(message: text)
    }
    
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
       
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if (string == " ") {
              return false
            }
            return true
        }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
