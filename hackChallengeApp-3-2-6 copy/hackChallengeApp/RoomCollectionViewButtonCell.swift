//
//  RoomCollectionViewButtonCell.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 11/30/22.
//

import UIKit

class RoomCollectionViewButtonCell: UICollectionViewCell {
     
    var bookLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = UIColor(red: 0.99, green: 0.66, blue: 0.56, alpha: 1.0)
//        contentView.backgroundColor = .black
        
        //setting up the book label
        bookLabel.text = "Book"
        bookLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        bookLabel.translatesAutoresizingMaskIntoConstraints = false
        bookLabel.font = .systemFont(ofSize: 14,weight: .semibold)
        contentView.insertSubview(bookLabel, at: 3)
        
        //setting up the book label
        NSLayoutConstraint.activate([
        
            bookLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 7),
            bookLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 24),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
