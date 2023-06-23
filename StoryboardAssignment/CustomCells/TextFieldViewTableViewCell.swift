//
//  TextFieldViewTableViewCell.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 15/06/23.
//

import UIKit

protocol TextfieldTapDelegate: AnyObject{
    func birthDateTapped()
    func genderTapped(textField: UITextField)
    func updatePassword(text: String)
    func updateConfirmPassword(text: String)
    func updateUserName(text: String)
    
}

class TextFieldViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eyeButton: UIButton!
    static var identifier = "TextFieldViewTableViewCell"
    weak var delegate: TextfieldTapDelegate?
    @IBOutlet weak var inputTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextField.borderStyle = .roundedRect
        inputTextField.delegate = self
        inputTextField.disableAutoFill()
        let tapgestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapgestureRecogniser.numberOfTapsRequired = 1
        inputTextField.addGestureRecognizer(tapgestureRecogniser)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended{
            inputTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func eyeButtonTapped(_ sender: UIButton) {
        inputTextField.isSecureTextEntry = !inputTextField.isSecureTextEntry
    }
    
    func configureCell(type: RegisterViewItem, person: Person?) {
        inputTextField.placeholder = type.getPlaceholder()
        inputTextField.tag = type.rawValue
        inputTextField.isSecureTextEntry = type == .confirmPassword || type == .password
        eyeButton.isHidden = !(type == .confirmPassword || type == .password)
        guard let person = person else {return}
        updateValue(person: person , type: type)
    }
    
    func updateValue(person: Person, type: RegisterViewItem) {
        switch type {
        case .gender:
            guard RegisterViewItem(rawValue: inputTextField.tag) == .gender else {
                return
            }
            if person.gender.isEmpty
            { inputTextField.placeholder =  type.getPlaceholder() }
            else
            { inputTextField.text =  person.gender }
        case .birthDate:
            guard RegisterViewItem(rawValue: inputTextField.tag) == .birthDate else {
                return
            }
            if person.birthDate.isEmpty
            { inputTextField.placeholder = type.getPlaceholder() }
            else
            { inputTextField.text =  person.birthDate }
        default:
            break
        }
    }
    
}


extension TextFieldViewTableViewCell: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let type = RegisterViewItem(rawValue: textField.tag) {
            switch type {
            case .gender,.birthDate:
                type == .birthDate ? self.delegate?.birthDateTapped() : self.delegate?.genderTapped(textField: textField)
                return false
            default:
                return true
            }
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        if let tag = RegisterViewItem(rawValue: textField.tag) {
            switch tag {
            case .name:
                delegate?.updateUserName(text: textField.text ?? "")
            case .password:
                delegate?.updatePassword(text: textField.text ?? "")
            case .confirmPassword:
                delegate?.updateConfirmPassword(text: textField.text ?? "")
            default:
                break
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}
