//
//  ProfileGradientView.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 12/2/22.
//

import UIKit

class ProfileGradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(red: 0.45, green: 0.33, blue: 0.96, alpha: 1).cgColor,
            UIColor(red: 0.68, green: 0.54, blue: 0.94, alpha: 1).cgColor,
            UIColor(red: 0.79, green: 0.69, blue: 0.92, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.92, blue: 0.89, alpha: 1).cgColor
        ]
        gradient.locations = [0.12,0.51,0.74,1.0]
        layer.addSublayer(gradient)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
