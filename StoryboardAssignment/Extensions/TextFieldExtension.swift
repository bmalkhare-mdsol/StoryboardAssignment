//
//  TextFieldExtension.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 22/06/23.
//

import Foundation
import UIKit

extension UITextField {
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}
