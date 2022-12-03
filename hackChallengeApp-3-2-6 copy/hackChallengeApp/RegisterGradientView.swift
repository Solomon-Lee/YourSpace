//
//  RegisterGradientView.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 11/28/22.
//

import UIKit

class RegisterGradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(red: 1, green: 0.92, blue: 0.89, alpha: 1).cgColor,
            UIColor(red: 0.63, green: 0.52, blue: 0.94, alpha: 1).cgColor,
            UIColor(red: 0.46, green: 0.34, blue: 0.97, alpha: 1).cgColor
        ]

        gradient.locations = [0.0,0.48,0.74]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        layer.addSublayer(gradient)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
