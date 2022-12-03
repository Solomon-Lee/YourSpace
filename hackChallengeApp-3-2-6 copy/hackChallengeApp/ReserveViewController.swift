//
//  ReserveViewController.swift
//  HackathonApp
//
//  Created by Wei Zheng on 11/24/22.
//

import UIKit
import DropDown
import BonsaiController
import Jelly

class ReserveViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var animator: Jelly.Animator?
    
    let bookingUnderSpace = UILabel()
    let topBackgroundView  = GradientView(frame: CGRect(x: 0, y: 0, width: 400, height: 217))
    let profilepicCircle = UIView()
    var personProfilePic = UIImageView()
    let spacelabel = UILabel()
//    let roomSearchBar = UISearchBar()
    let backgroundLines = UIImageView()
    let roomMenu = DropDown()
    let roomMenuView = UIView(frame: CGRect(x: 0, y: 0, width: 201, height: 42))
    let roomMenuText = UILabel()
    let roomMenuPic = UIImageView()
    var rooms = [Spacess]()
//    var roomsCopy = [Spacess]()
    var roomCollectionView: UICollectionView!
//    var bookCollectionView: UICollectionView!
    let roomReuseIdentifier: String = "roomReuseIdentifier"
//    let bookReuseIdentifier: String = "bookReyseIdentifier"
    

    
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        title = "List"
        view.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.96, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        //setting up the booking under space
        bookingUnderSpace.text = "Book Your Space below."
        bookingUnderSpace.translatesAutoresizingMaskIntoConstraints = false
        bookingUnderSpace.font = .systemFont(ofSize: 16, weight: .regular)
        bookingUnderSpace.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.insertSubview(bookingUnderSpace, at: 3)
        
        //setting up the backgroundline
        backgroundLines.image = UIImage(named: "homeAndSpacesBackground")
        backgroundLines.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundLines, at: 0)
        
        //setting up the space label
        spacelabel.text = "Spaces"
        spacelabel.font = .systemFont(ofSize: 36,weight: .semibold)
        spacelabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        spacelabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(spacelabel, at: 3)
        
        //setting up the topbackgroundView
        topBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(topBackgroundView, at: 0)
        
        //setting up the profilepiccircle
        profilepicCircle.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        profilepicCircle.translatesAutoresizingMaskIntoConstraints = false
        profilepicCircle.clipsToBounds = false
        profilepicCircle.layer.cornerRadius = 30
        view.insertSubview(profilepicCircle, at: 2)
        
        //setting up the personProfile view
        personProfilePic.image = UIImage(named: "Path")
        personProfilePic.translatesAutoresizingMaskIntoConstraints = false
        personProfilePic.clipsToBounds = true
        view.insertSubview(personProfilePic, at: 3)
        
        //setting up the search bar
        
//        roomSearchBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
//        roomSearchBar.layer.shadowRadius = 7
//        roomSearchBar.layer.shadowOpacity = 1
//        roomSearchBar.layer.shadowOffset = .init(width: 0, height: 4)
//        roomSearchBar.backgroundColor = .white
//        roomSearchBar.placeholder = "Find a room"
//        roomSearchBar.layer.masksToBounds = true
//        roomSearchBar.layer.cornerRadius = 24
//        roomSearchBar.searchTextField.backgroundColor = .clear
//        roomSearchBar.tintColor = .clear
//        roomSearchBar.isTranslucent =  false
//        roomSearchBar.translatesAutoresizingMaskIntoConstraints = false
//        view.insertSubview(roomSearchBar, at: 2)
        
        //setting up the dropdown menu
        roomMenuText.font = .systemFont(ofSize: 18,weight: .semibold)
        roomMenuText.textColor = UIColor(red: 0.45, green: 0.24, blue: 0.79, alpha: 1.0)
        roomMenuText.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(roomMenuText, at: 3)
        
        roomMenuPic.image = UIImage(named: "Frame")
        roomMenuPic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(roomMenuPic, at: 3)
        
        roomMenuView.clipsToBounds = true
        roomMenuView.layer.cornerRadius = 4
        roomMenuView.layer.shadowOpacity = 0.5
        roomMenuView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        roomMenuView.layer.shadowOffset = .init(width: 0, height: 4)
        roomMenuView.layer.shadowRadius = 7
        roomMenuView.backgroundColor = .white
        roomMenuView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(roomMenuView, at: 2)
        
        roomMenu.dataSource = ["All Rooms", "Classrooms", "Computer Labs", "Group Study", "Meeting Rooms"]
        roomMenu.anchorView = roomMenuView
        roomMenu.selectRow(at: 0)
        roomMenuText.text = roomMenu.selectedItem

        roomMenu.cornerRadius = 4
        DropDown.appearance().selectionBackgroundColor = UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1)
        DropDown.appearance().selectedTextColor = .white
        DropDown.appearance().backgroundColor = .white
        roomMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.roomMenuText.text = item
//            filter()
//          print("Selected item: \(item) at index: \(index)")
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        roomMenuView.addGestureRecognizer(gesture)
        
        //setting up the room collectionView
        let roomLayout = UICollectionViewFlowLayout()
        roomLayout.minimumLineSpacing = 16
        roomLayout.minimumInteritemSpacing = 98
        roomLayout.scrollDirection = .vertical
        
        roomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: roomLayout)
        
        roomCollectionView.tintColor = UIColor(red: 1, green: 0.98, blue: 0.96, alpha: 1)
        roomCollectionView.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.96, alpha: 1)
        roomCollectionView.register(RoomCollectionViewCell.self, forCellWithReuseIdentifier: roomReuseIdentifier)
        roomCollectionView.dataSource = self
        roomCollectionView.delegate = self
        roomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(roomCollectionView, at: 3)
        
        //setting up the book collectionview
        let bookLayout = UICollectionViewFlowLayout()
        bookLayout.minimumLineSpacing = 67
        bookLayout.scrollDirection = .vertical

        
        
        //setting up the constraints for topbackgroundview
        NSLayoutConstraint.activate([
            topBackgroundView.heightAnchor.constraint(equalToConstant: 234),
            topBackgroundView.widthAnchor.constraint(equalToConstant: 390),
        ])
        
        //setting up the person profile pic
        NSLayoutConstraint.activate([
            personProfilePic.heightAnchor.constraint(equalToConstant: 20.65),
            personProfilePic.widthAnchor.constraint(equalToConstant: 20.65),
            personProfilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 35),
            personProfilePic.leftAnchor.constraint(equalTo: profilepicCircle.leftAnchor, constant: 19.35),
        ])
        
        //setting up the profile circle view
        NSLayoutConstraint.activate([
            profilepicCircle.heightAnchor.constraint(equalToConstant: 60),
            profilepicCircle.widthAnchor.constraint(equalToConstant: 60),
            profilepicCircle.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 295),
            profilepicCircle.topAnchor.constraint(equalTo: personProfilePic.topAnchor,constant: -19.35)
        ])
        
        //setting up the space Label
        NSLayoutConstraint.activate([
            spacelabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 45),
            spacelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 35)
        
        ])
        
        //setting up the search bar
//        NSLayoutConstraint.activate([
//            roomSearchBar.topAnchor.constraint(equalTo: spacelabel.bottomAnchor,constant: 20),
//            roomSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
//            roomSearchBar.heightAnchor.constraint(equalToConstant: 47),
//            roomSearchBar.widthAnchor.constraint(equalToConstant: 315),
//        ])
        
        //setting up the booking under space
        
        NSLayoutConstraint.activate([
        
            bookingUnderSpace.topAnchor.constraint(equalTo: spacelabel.bottomAnchor,constant: 5),
            bookingUnderSpace.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 34)
        
        ])
        
        //setting up the constraints for the background lines
        NSLayoutConstraint.activate([
            backgroundLines.heightAnchor.constraint(equalToConstant: 217),
            backgroundLines.widthAnchor.constraint(equalToConstant: 390),
        ])
        
        //setting up the constraints for the dropdown menu view
        NSLayoutConstraint.activate([
            roomMenuView.widthAnchor.constraint(equalToConstant: 201),
            roomMenuView.heightAnchor.constraint(equalToConstant: 42),
            roomMenuView.topAnchor.constraint(equalTo: bookingUnderSpace.bottomAnchor,constant: 60),
            roomMenuView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 19)
        
        ])
        
        //setting up the constraints for the roommenu text
        NSLayoutConstraint.activate([
        
            roomMenuText.topAnchor.constraint(equalTo: roomMenuView.topAnchor,constant: 10),
            roomMenuText.leadingAnchor.constraint(equalTo: roomMenuView.leadingAnchor,constant: 15),
            roomMenuText.trailingAnchor.constraint(equalTo: roomMenuView.trailingAnchor,constant: -25),
        
        ])
        
        //setting up constraints for the room menu picture
        NSLayoutConstraint.activate([
        
            roomMenuPic.topAnchor.constraint(equalTo: roomMenuView.topAnchor,constant: 10),
            roomMenuPic.trailingAnchor.constraint(equalTo: roomMenuView.trailingAnchor,constant: -12),
            roomMenuPic.heightAnchor.constraint(equalToConstant: 24),
            roomMenuPic.widthAnchor.constraint(equalToConstant: 24),
        
        ])
        
        //setting up the room collection view
        NSLayoutConstraint.activate([
        
            roomCollectionView.topAnchor.constraint(equalTo: roomMenuView.bottomAnchor,constant: 20),
            roomCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 19),
            roomCollectionView.heightAnchor.constraint(equalToConstant: 490),
            roomCollectionView.widthAnchor.constraint(equalToConstant: 354),
        
            
        ])
        
        //setting up the book collection view
//        NSLayoutConstraint.activate([
//
//            bookCollectionView.topAnchor.constraint(equalTo: roomCollectionView.topAnchor,constant: 26),
//            bookCollectionView.widthAnchor.constraint(equalToConstant: 83),
//            bookCollectionView.heightAnchor.constraint(equalToConstant: 490),
//            bookCollectionView.trailingAnchor.constraint(equalTo: roomCollectionView.trailingAnchor,constant: -17),
//
//        ])
        getSpaces()
    }
    @objc func didTapMenu(){
        roomMenu.show()
    }

    
//    func filter(){
//
//        roomsCopy = []
//
//        if roomMenu.selectedItem == "Classrooms"{
//            rooms = rooms + roomsCopy.filter({ space in
//                space.id == 0
//            })
//        }
//    }
    
    func getSpaces(){
        NetworkManager.getAllBookings { spaces in
            self.rooms = spaces
            DispatchQueue.main.async{
                self.roomCollectionView.reloadData()
            }
        }
    }
    
    

}

extension ReserveViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
//        if collectionView == roomCollectionView{
            let roomcell = roomCollectionView.dequeueReusableCell(withReuseIdentifier: roomReuseIdentifier, for: indexPath) as! RoomCollectionViewCell
            roomcell.roomConfigure(room: rooms[indexPath.row])
            roomcell.parent = self
            return roomcell
//        }
        
//            let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: bookReuseIdentifier, for: indexPath) as! RoomCollectionViewButtonCell
//            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension ReserveViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == roomCollectionView{
            return CGSize(width: 354, height: 81)
        }
        return CGSize(width: 83, height: 30)
    }
}


extension ReserveViewController: changeDropdownIndexDelegate{
    func changeNum(num: Int) {
        roomMenu.selectRow(at : num)
        roomMenuText.text = roomMenu.selectedItem
    }
    
    
}


