//
//  GradientView.swift
//  HackathonApp
//
//  Created by Wei Zheng on 11/25/22.
//

import UIKit

class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(red: 0.45, green: 0.33, blue: 0.96, alpha: 1).cgColor,
            UIColor(red: 0.68, green: 0.57, blue: 0.93, alpha: 1).cgColor,
            UIColor(red: 0.92, green: 0.83, blue: 0.9, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.92, blue: 0.89, alpha: 1).cgColor
        ]
        gradient.locations = [0.09,0.75,0.9,1.0]
        layer.addSublayer(gradient)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

