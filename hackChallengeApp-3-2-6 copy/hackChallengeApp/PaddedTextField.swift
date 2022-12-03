//
//  PaddedTextField.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 11/28/22.
//

import UIKit

class paddedTextField: UITextField {
    

    let placeholderPadding = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 2)
    let padding = UIEdgeInsets(top: 25, left: 5, bottom: -15, right: 0)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return bounds.inset(by: placeholderPadding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return bounds.inset(by: padding)
    }

}

