//
//  BookingPresentViewController.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 11/30/22.
//

import UIKit
import BonsaiController
import DropDown

class BookingPresentViewController: UIViewController {
    
    let idPlaceholder = UILabel()
    static var tokenPlaceholder: String?
    let libraryLabel = UILabel()
    let dateDropMenu = DropDown()
    let dateMenuView = UIView(frame: CGRect(x: 0, y: 0, width: 315, height: 31))
    let dateMenuText = UILabel()
    let dateMenuImage = UIImageView()
    let dateMenuLabel = UILabel()
    let bookButton = UIButton()
    let dateLabel = UILabel()
    let todayBox = UIView()
    let todayLabel = UILabel()
    let dateConfirmationView = UIView()
    let dateConfirmationLabel = UILabel()
    let dateConfirmationText = UILabel()
    let dateConfirmationDesc = UILabel()
    let dateConfirmationImage = UIImageView()
    
    var delegate: profileTokenDelegate?
    
    init(delegate: profileTokenDelegate){
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
        view.backgroundColor = .white
        

        
//        let xCoord = self.view.bounds.width / 2 - 50
//        let yCoord = self.view.bounds.height / 2 - 50
        
//        let centerView = UIView(frame: CGRect(x: 0, y: view.bounds.height/1.55, width: view.bounds.width, height: view.bounds.height/(4/3)))
//        centerView.backgroundColor = .white
//
//        self.view.insertSubview(centerView, at: 0)
        
        // get the current date and time
        let currentDateTime = Date()

        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long

        // get the date time String from the date object
//        formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
        
        // "October 8, 2016"
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        formatter.string(from: currentDateTime)
        
        
//        print(currentDateTime)
    

        
        todayLabel.text = formatter.string(from: currentDateTime)
        todayLabel.textColor = UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1.0)
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        view.insertSubview(todayLabel, at: 3)
        
        todayBox.clipsToBounds = true
        todayBox.layer.borderWidth = 2
        todayBox.layer.borderColor = UIColor(red: 0.69, green: 0.63, blue: 0.79, alpha: 1.0).cgColor
        todayBox.backgroundColor = .clear
        todayBox.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(todayBox, at: 3)
        
        dateLabel.text = "Date"
        dateLabel.textColor = UIColor(red: 0.69, green: 0.63, blue: 0.79, alpha: 1.0)
        dateLabel.font = .systemFont(ofSize: 16, weight: .regular)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(dateLabel, at: 3)
        
//        libraryLabel.text = "B60 Kroch Library"
        libraryLabel.textColor = UIColor(red: 0.45, green: 0.24, blue: 0.79, alpha: 1.0)
        libraryLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        libraryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(libraryLabel, at: 3)
        
        dateMenuLabel.text = "Timeslot"
        dateMenuLabel.font = .systemFont(ofSize: 16, weight: .regular)
        dateMenuLabel.translatesAutoresizingMaskIntoConstraints = false
        dateMenuLabel.textColor = UIColor(red: 0.69, green: 0.63, blue: 0.79, alpha: 1.0)
        view.insertSubview(dateMenuLabel, at: 3)
        
        dateMenuText.font = .systemFont(ofSize: 18,weight: .semibold)
        dateMenuText.text = "Select a Time"
        dateMenuText.font = .systemFont(ofSize: 18, weight: .semibold)
        dateMenuText.textColor = UIColor(red: 0.6196, green: 0.5098, blue: 0.9451, alpha: 1.0)
        dateMenuText.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(dateMenuText, at: 3)
        
        dateMenuImage.image = UIImage(named: "Vector")
        dateMenuImage.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(dateMenuImage, at: 4)

        dateMenuView.clipsToBounds = true
        dateMenuView.layer.borderColor = UIColor(red: 0.69, green: 0.63, blue: 0.79, alpha: 1.0).cgColor
        dateMenuView.layer.borderWidth = 2
        dateMenuView.backgroundColor = .clear
        dateMenuView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(dateMenuView, at: 3)
        
        
        dateDropMenu.dataSource = []
        dateDropMenu.anchorView = dateMenuView
        dateDropMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dateMenuText.text = item
        }
        
        DropDown.appearance().backgroundColor = .white
        DropDown.appearance().selectedTextColor = .white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDate))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        dateMenuView.addGestureRecognizer(gesture)
        
        bookButton.setTitle("Book", for: .normal)
        bookButton.setTitleColor(.white, for: .normal)
        bookButton.backgroundColor = UIColor(red: 0.99, green: 0.66, blue: 0.56, alpha: 1.0)
        bookButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        bookButton.clipsToBounds = true
        bookButton.layer.cornerRadius = 17
        bookButton.addTarget(self, action: #selector(bookConfirmation), for: .touchUpInside)
        bookButton.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(bookButton, at: 3)
        
        setupConstraints()
    }
    
     func addBooking(){
//         print("ASDFASDF: Bearer \(BookingPresentViewController.tokenPlaceholder!)")

//         NetworkManager.AddaUserToaBookingById(id: Int(idPlaceholder.text!) ?? 0, Authorization: "Bearer \(BookingPresentViewController.tokenPlaceholder!)") { response in
//
//            print(BookingPresentViewController.tokenPlaceholder ?? "abc")
//
//            print(response)
//
//        }
         NetworkManager.AddaUserToaBookingById(id: Int(idPlaceholder.text!) ?? 0, token: BookingPresentViewController.tokenPlaceholder!) { response in
//             print(BookingPresentViewController.tokenPlaceholder!)
//             print(response)
         }
         self.delegate?.changeProfileToken(token: BookingPresentViewController.tokenPlaceholder!)


        
       
//        NetworkManager.AddaUserToaBookingById(id: 10, Authorization: "Bearer \(tokenPlaceholder.text)") { response in
//            print(response)
//        }
    }
    
    
    
    
    @objc func bookConfirmation() {
        
        addBooking()
        dateConfirmationView.backgroundColor = .white
        dateConfirmationView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(dateConfirmationView, at: 5)
        
        
        libraryLabel.text = ""
        
        dateMenuText.text = ""
        
        dateMenuLabel.text = ""
         
//         tokenPlaceholder.textColor = .black
//         tokenPlaceholder.translatesAutoresizingMaskIntoConstraints = false
//         view.addSubview(tokenPlaceholder)
        
        dateConfirmationLabel.text = "Confirmation"
        dateConfirmationLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        dateConfirmationLabel.translatesAutoresizingMaskIntoConstraints = false
        dateConfirmationLabel.textColor = UIColor(red: 0.447, green: 0.239, blue: 0.788, alpha: 1.0)
        view.addSubview(dateConfirmationLabel)
        
        dateConfirmationImage.image = UIImage(named: "confirmation")
        dateConfirmationImage.translatesAutoresizingMaskIntoConstraints = false
        dateConfirmationImage.clipsToBounds = true
        view.addSubview(dateConfirmationImage)
        
        dateConfirmationText.text = "Space successfully booked."
        dateConfirmationText.font = .systemFont(ofSize: 18, weight: .semibold)
        dateConfirmationText.textColor = UIColor(red: 0.619, green: 0.509, blue: 0.945, alpha: 1.0)
        dateConfirmationText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateConfirmationText)
        
        dateConfirmationDesc.text = "Manage your spaces in the profile page"
        dateConfirmationDesc.font = .systemFont(ofSize: 16, weight: .regular)
        dateConfirmationDesc.textColor = UIColor(red: 0.69, green: 0.627, blue: 0.788, alpha: 1.0)
        dateConfirmationDesc.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateConfirmationDesc)
        
        confirmationConstraints()
        
    }
    func confirmationConstraints() {
        
        //placeholder
        
//        NSLayoutConstraint.activate([
//            tokenPlaceholder.topAnchor.constraint(equalTo: view.topAnchor,constant: 2),
//            tokenPlaceholder.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5)
//
//        ])
        
        //confirmationView
        NSLayoutConstraint.activate([
            dateConfirmationView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            dateConfirmationView.heightAnchor.constraint(equalToConstant: view.bounds.height),
            dateConfirmationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //dateImageView
        NSLayoutConstraint.activate([
            dateMenuImage.widthAnchor.constraint(equalToConstant: 0),
            dateMenuImage.heightAnchor.constraint(equalToConstant: 0)
        ])
        
        //dateConfirmationLabel
        NSLayoutConstraint.activate([
            dateConfirmationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateConfirmationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56)
        ])
        
        //dateConfirmationImage
        NSLayoutConstraint.activate([
            dateConfirmationImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateConfirmationImage.topAnchor.constraint(equalTo: dateConfirmationLabel.bottomAnchor, constant: 30),
            dateConfirmationImage.widthAnchor.constraint(equalToConstant: 50),
            dateConfirmationImage.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //dateConfirmationText
        NSLayoutConstraint.activate([
            dateConfirmationText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateConfirmationText.topAnchor.constraint(equalTo: dateConfirmationImage.bottomAnchor, constant: 16)
        ])
        
        //dateConfirmationDesc
        NSLayoutConstraint.activate([
            dateConfirmationDesc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateConfirmationDesc.topAnchor.constraint(equalTo: dateConfirmationText.bottomAnchor, constant: 8)
        ])
        
    }

    

    
    func setupConstraints() {
        
        //datelabel
        NSLayoutConstraint.activate([
        
            dateLabel.topAnchor.constraint(equalTo: libraryLabel.bottomAnchor,constant: 10.52),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 31),
        
        ])
        
//        dateMenuLabel
        NSLayoutConstraint.activate([
            dateMenuLabel.topAnchor.constraint(equalTo: libraryLabel.bottomAnchor, constant: 85),
            dateMenuLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31)
        ])
        
        //dateMenuView
        NSLayoutConstraint.activate([
            dateMenuView.topAnchor.constraint(equalTo: dateMenuLabel.bottomAnchor, constant: 4),
            dateMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            dateMenuView.heightAnchor.constraint(equalToConstant: 31),
            dateMenuView.widthAnchor.constraint(equalToConstant: 266.21)
        ])
        
        //dateMenuText
        NSLayoutConstraint.activate([
            dateMenuText.topAnchor.constraint(equalTo: dateMenuView.topAnchor, constant: 4.9),
            dateMenuText.leadingAnchor.constraint(equalTo: dateMenuView.leadingAnchor, constant: 9.32),
            dateMenuText.widthAnchor.constraint(equalToConstant: 235.6),
            dateMenuText.heightAnchor.constraint(equalToConstant: 21.54)
        ])
        
        //dateMenuImage
        NSLayoutConstraint.activate([
            dateMenuImage.topAnchor.constraint(equalTo: dateMenuView.topAnchor, constant: 13.71),
            dateMenuImage.trailingAnchor.constraint(equalTo: dateMenuView.trailingAnchor, constant: -11.75)
        ])
        
        //bookButton
        NSLayoutConstraint.activate([
            bookButton.topAnchor.constraint(equalTo: dateMenuView.bottomAnchor, constant: 30),
            bookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookButton.widthAnchor.constraint(equalToConstant: 166),
            bookButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        //library label
        NSLayoutConstraint.activate([
        
            libraryLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 33),
            libraryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 31)
        
        ])
        
        //todayBox
        NSLayoutConstraint.activate([
            
            todayBox.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 3),
            todayBox.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 31),
            todayBox.heightAnchor.constraint(equalToConstant: 31),
            todayBox.widthAnchor.constraint(equalToConstant: 315.46)
        
        ])
        
        //todaylabel
        
        NSLayoutConstraint.activate([
        
            todayLabel.topAnchor.constraint(equalTo: todayBox.topAnchor,constant: 4.9),
            todayLabel.leadingAnchor.constraint(equalTo: todayBox.leadingAnchor,constant: 9.32)
        
        ])
    }
    
    @objc func didTapDate() {
        dateDropMenu.show()
    }

}

extension BookingPresentViewController: passTokenDelegate{
     func changeToken(token: String) {
        BookingPresentViewController.tokenPlaceholder = token
        print(BookingPresentViewController.tokenPlaceholder!)
//        print(token)

    }
    
    
}

protocol profileTokenDelegate: UIViewController{
    func changeProfileToken(token: String)
}






