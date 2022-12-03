//
//  GradientButton.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 11/28/22.
//

import UIKit

class GradientButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(red: 1, green: 0.79, blue: 0.79, alpha: 1).cgColor,
            UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1).cgColor
        ]
        gradient.locations = [0.01,1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.addSublayer(gradient)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
