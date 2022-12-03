//
//  ProfileTableCollectionViewCell.swift
//  hackChallengeApp
//
//  Created by user227825 on 12/2/22.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    var libraryNameLabel = UILabel()
    var fullNameLabel = UILabel()
    var capacityLabel = UILabel()
    let line1 = UIView()
    var timeSlot = UILabel()
    var dateSlot = UILabel()
    var idLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .init(width: 0, height: 4)
        
        //setting up the library name label
        libraryNameLabel.textColor = UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1)
        libraryNameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        libraryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(libraryNameLabel)
        
        //setting up the fullname label
        fullNameLabel.textColor = UIColor(red: 0.59, green: 0.53, blue: 0.68, alpha: 1.0)
        fullNameLabel.font = .systemFont(ofSize: 11, weight: .regular)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fullNameLabel)
        
        //setting up the Capacity label
        capacityLabel.font = .systemFont(ofSize: 11, weight: .regular)
        capacityLabel.textColor = UIColor(red: 0.59, green: 0.53, blue: 0.68, alpha: 1.0)
        capacityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(capacityLabel)
        
        line1.backgroundColor = UIColor(red: 0.99, green: 0.66, blue: 0.56, alpha: 1.0)
        line1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(line1)
        
        timeSlot.textColor = UIColor(red: 0.99, green: 0.66, blue: 0.56, alpha: 1.0)
        timeSlot.font = .systemFont(ofSize: 14, weight: .semibold)
        contentView.addSubview(timeSlot)
        
        dateSlot.textColor = UIColor(red: 0.99, green: 0.66, blue: 0.56, alpha: 1.0)
        dateSlot.font = .systemFont(ofSize: 11, weight: .regular)
        contentView.addSubview(dateSlot)
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(idLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        //libraryNameLabel
        NSLayoutConstraint.activate([
            libraryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            libraryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
        
        //fullNameLabel
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: libraryNameLabel.bottomAnchor, constant: 5),
            fullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
//
//        //capacityLabel
        NSLayoutConstraint.activate([
            capacityLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 3),
            capacityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
//
//        //line1
        NSLayoutConstraint.activate([
            line1.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -111),
            line1.widthAnchor.constraint(equalToConstant: 1),
            line1.heightAnchor.constraint(equalToConstant: 59),
            line1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
//
//        //timeSlot
//        NSLayoutConstraint.activate([
//            timeSlot.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
//            timeSlot.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
//        ])

//        dateSlot
//        NSLayoutConstraint.activate([
//            dateSlot.topAnchor.constraint(equalTo: timeSlot.bottomAnchor, constant: 2),
//            dateSlot.leadingAnchor.constraint(equalTo: line1.trailingAnchor, constant: 29)
//        ])
        
    }
    
    func profileConfigure(profile: Spacess) {
        libraryNameLabel.text = profile.name
        fullNameLabel.text = profile.location
        capacityLabel.text = "Capacity: \(profile.capacity)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
