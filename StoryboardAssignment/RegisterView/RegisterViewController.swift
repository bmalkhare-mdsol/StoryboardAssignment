//
//  RegisterViewController.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 14/06/23.
//

import UIKit
import SQLite3

class RegisterViewController: UIViewController {
    
    var configurator: RegisterViewConfigurator?
    var presenter: RegisterViewPresenter!
    let datePicker = UIDatePicker()
    @IBOutlet weak var registerTableView: UITableView!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        configurator = RegisterViewConfiguratorImpl(viewController: self)
        configurator?.configure()
        registerTableView.separatorStyle = .none
        registerTableView.selectionFollowsFocus = false
        self.registerTableView.register(UINib(nibName: TextFieldViewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TextFieldViewTableViewCell.identifier)
        self.navigationItem.title = RegisterViewConstants.signUp.rawValue
        signInButton.layer.cornerRadius = 8
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
           view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
   
    
    
    @IBAction func signInTapped(_ sender: UIButton) {
        view.endEditing(true)
        presenter.signInTapped()
    }
    
    
}
extension RegisterViewController: UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RegisterViewItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = RegisterViewItem(rawValue: indexPath.row) {
            switch item {
            case .name,.birthDate,.gender,.password,.confirmPassword:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldViewTableViewCell.identifier) as! TextFieldViewTableViewCell
                cell.configureCell(type: item, person: presenter.person)
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    
}
extension RegisterViewController: TextfieldTapDelegate{
    func updatePassword(text: String) {
        presenter.updatePassword(text: text)
    }
    
    func updateConfirmPassword(text: String) {
        presenter.updateConfirmPassword(text: text)
    }
    
    func updateUserName(text: String) {
        presenter.updateUserName(text: text)
    }
    
    
    func genderTapped(textField: UITextField) {
        showMenu(textField: textField)
    }
    
    func birthDateTapped() {
        showAlert()
    }
    func showMenu(textField: UITextField){
        let alert = UIAlertController(title: "Select Gender", message: nil, preferredStyle: .actionSheet)
        let maleAction = UIAlertAction(title: Gender.male.getTitle(), style: .default, handler: { _ in
            self.presenter.updateGender(gender: Gender.male)
        })
        let femaleAction = UIAlertAction(title: Gender.female.getTitle(), style: .default, handler: { _ in
            self.presenter.updateGender(gender: Gender.female)
        })
        alert.addAction(maleAction)
        alert.addAction(femaleAction)
        if let popoverController = alert.popoverPresentationController{
            popoverController.sourceView = textField
            popoverController.sourceRect = textField.bounds
            popoverController.permittedArrowDirections = [.down,.up]
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(){
        let alert = UIAlertController(title: RegisterViewConstants.selectDate.rawValue, message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 40, width: 250, height: 150)
        alert.view.addSubview(datePicker)
        let selectAction = UIAlertAction(title: RegisterViewConstants.ok.rawValue, style: .default, handler: { _ in
            self.presenter.updateBirthDate(text: self.datePicker.date.getDate())
        })
        let cancelAction = UIAlertAction(title: RegisterViewConstants.cancel.rawValue, style: .cancel, handler: nil)
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension RegisterViewController:  RegisterDataView {
    func showToast(text: String) {
        self.showToastMessage(message: text)
    }
    
    func showAlert(text: String) {
        self.showAlert(message: text)
    }
    
    func reloadTable(type: RegisterViewItem) {
        let indexPath = IndexPath(item: type.rawValue, section: 0)
        registerTableView.reloadRows(at: [indexPath], with: .top)
    }
    
    
}
