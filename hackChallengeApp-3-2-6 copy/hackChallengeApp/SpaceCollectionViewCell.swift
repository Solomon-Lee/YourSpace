//
//  SpaceCollectionViewCell.swift
//  HackathonApp
//
//  Created by Wei Zheng on 11/24/22.
//

import UIKit

class SpaceCollectionViewCell: UICollectionViewCell {
    
    var spacePic = UIImageView()
    var spaceName = UILabel()
    var availableSpace = UILabel()
    

    
//    weak var parent: HomeViewController?

//    weak var delegate: changeDropdownIndexDelegate?

    
    override init(frame: CGRect){
        super.init(frame: frame)
//        self.delegate = ReserveViewController()
        contentView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        contentView.layer.cornerRadius = 12
        
        
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowOffset = .init(width: 0, height: 4)
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        
        //settting up the space pic
        spacePic.translatesAutoresizingMaskIntoConstraints = false
        spacePic.clipsToBounds = true
        spacePic.layer.cornerRadius = 12
        contentView.addSubview(spacePic)
        
        //seting up the spaceName

            spaceName.font = .systemFont(ofSize: 16, weight: .semibold)
  
        spaceName.textColor = UIColor(red: 0.99, green: 0.66, blue: 0.56, alpha: 1.0)
        spaceName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spaceName)
        
        //setting up the availableSpace label
        availableSpace.textColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
        availableSpace.font = .systemFont(ofSize: 14,weight: .regular)
        availableSpace.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(availableSpace)
        
        //setting up the space pic
        NSLayoutConstraint.activate([
            spacePic.widthAnchor.constraint(equalToConstant: 140),
            spacePic.heightAnchor.constraint(equalToConstant: 140),
            spacePic.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 13),
            spacePic.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 11),
        ])
        
        //setting up the space name label
        NSLayoutConstraint.activate([
            spaceName.topAnchor.constraint(equalTo: spacePic.bottomAnchor,constant: 14),
            spaceName.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 13),
        ])
        
        //setting up the available number
        NSLayoutConstraint.activate([
            availableSpace.topAnchor.constraint(equalTo: spaceName.bottomAnchor, constant: 1),
            availableSpace.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 13),
        ])
    }
    
    func spaceConfigure(space: Spaces){
        spacePic.image = UIImage(named: space.pic)
        if space.name == "Group Study Rooms"{
            spaceName.font = .systemFont(ofSize: 15, weight: .semibold)
            spaceName.text = space.name
        }
        else{
            spaceName.text = space.name
        }
        
        availableSpace.text = space.availableSpace + " available spaces"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol changeDropdownIndexDelegate: UIViewController{
    func changeNum(num:Int)
}

