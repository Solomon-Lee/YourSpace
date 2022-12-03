//
//  RoomCollectionViewCell.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 11/30/22.
//

import UIKit
import Jelly

class RoomCollectionViewCell: UICollectionViewCell {
    
    var animator: Jelly.Animator?
    
    var librarynameLabel = UILabel()
    var fullnameLabel = UILabel()
    let capacitylabel = UILabel()
    var bookButton = UIButton()
    var idLabel = UILabel()
    
    weak var parent: ReserveViewController?
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = .init(width: 0, height: 4)
        
        
        //setting up the library name label
        librarynameLabel.textColor = UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1)
        librarynameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        librarynameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(librarynameLabel, at: 3)
        
        //setting up the fullname label
        fullnameLabel.textColor = UIColor(red: 0.59, green: 0.53, blue: 0.68, alpha: 1.0)
        fullnameLabel.font = .systemFont(ofSize: 11, weight: .regular)
        fullnameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(fullnameLabel, at: 3)
        
        //setting up the Capacity label
        capacitylabel.font = .systemFont(ofSize: 11, weight: .regular)
        capacitylabel.textColor = UIColor(red: 0.59, green: 0.53, blue: 0.68, alpha: 1.0)
        capacitylabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(capacitylabel, at: 3)
        
//        setting up the book button
        bookButton.setTitle("Book", for: .normal)
        bookButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for:.normal)
        bookButton.translatesAutoresizingMaskIntoConstraints = false
        bookButton.backgroundColor = UIColor(red: 0.99, green: 0.66, blue: 0.56, alpha: 1.0)
        bookButton.clipsToBounds = true
        bookButton.layer.cornerRadius = 15
        bookButton.addTarget(self, action: #selector(onTap(sender:)), for: .touchUpInside)
        bookButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        contentView.insertSubview(bookButton, at: 3)
        
        idLabel.textColor = .white
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(idLabel, at: 0)
        
        //setting up the constraints for the library name label
        NSLayoutConstraint.activate([
        
            librarynameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            librarynameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15)
        
        ])
        
        //setting up the constraints for the id label
        
        NSLayoutConstraint.activate([
        
            idLabel.leadingAnchor.constraint(equalTo: capacitylabel.trailingAnchor,constant: 50),
            idLabel.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor,constant: 3)
        
        ])
        
        //setting up the constraints for the full name label
        
        NSLayoutConstraint.activate([
        
            fullnameLabel.topAnchor.constraint(equalTo: librarynameLabel.bottomAnchor,constant: 5),
            fullnameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
        ])
        
        //setting up the constraints for the capacity label
        NSLayoutConstraint.activate([
        
            capacitylabel.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor,constant: 3),
            capacitylabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
        ])
        
//        setting up the constraints for the book button
        NSLayoutConstraint.activate([

            bookButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 26),
            bookButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -17),
            bookButton.heightAnchor.constraint(equalToConstant: 30),
            bookButton.widthAnchor.constraint(equalToConstant: 83),
    
        ])
        
        
    }
    func roomConfigure(room: Spacess){
        librarynameLabel.text = room.name
        fullnameLabel.text = room.location
        capacitylabel.text = "Capacity: \(room.capacity)"
        idLabel.text = String(room.id)
        
    }
    
    @objc func onTap(sender: UIButton) {
//        print("tapped")
//       let destinationVC = BookingPresentViewController()
//          parent?.present(destinationVC,animated: true,completion: nil)
      

        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 35,
                                                          isTapBackgroundToDismissEnabled: true)
        let viewController = BookingPresentViewController(delegate: ProfileViewController())
        let alignment = PresentationAlignment(vertical: .bottom, horizontal: .left)
        let size = PresentationSize(width: .fullscreen,height: .custom(value: (parent?.view.bounds.height)!/(2.7)))
        let timing = PresentationTiming(duration: .slow, presentationCurve: .easeInOut, dismissCurve: .linear)

        let presentation = CoverPresentation(directionShow: .top, directionDismiss: .bottom,uiConfiguration: uiConfiguration, size: size, alignment: alignment,timing: timing)
        animator = Animator(presentation:presentation)
        animator?.prepare(presentedViewController: viewController)
        
        viewController.libraryLabel.text = librarynameLabel.text
        
        NetworkManager.getBookingsById(id: Int(idLabel.text!) ?? 0) { space in
            viewController.dateDropMenu.dataSource.append(space)
            viewController.idPlaceholder.text = self.idLabel.text
        }
        
        
        
        parent?.present(viewController, animated: true, completion: nil)
        
        
        
   }

    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





    
