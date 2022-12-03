//
//  ProfileViewController.swift
//  HackathonApp
//
//  Created by Wei Zheng on 11/24/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var tokenabc: String?
    let titleLabel = UILabel()
    let profileImage = UIImageView()
    let gradientColorView = ProfileGradientView(frame: CGRect(x: 0, y: 0, width: 400, height: 292))
    let profileName = UILabel()
    let schoolName = UILabel()
    let logoutButton = UIButton()
    let spacesLabel = UILabel()
    var profileTableView = UITableView()
    let profileReuseIdentifier: String = "profileReuseIdentifier"
    var bookings = [bookingDetails]()
    let background = UIImageView()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.image = UIImage(named: "profilePageBackground")
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)
        
        view.backgroundColor = UIColor(red: 1, green: 0.99, blue: 0.96, alpha: 1)
        titleLabel.text = "Profile"
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        profileImage.image = UIImage(named: "profile pic")
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImage)
        
        gradientColorView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(gradientColorView, at: 0)
        
        profileName.text = "Justin Ngai"
        profileName.textColor = .white
        profileName.font = .systemFont(ofSize: 20, weight: .semibold)
        profileName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileName)
        
        schoolName.text = "Cornell University"
        schoolName.textColor = .white
        schoolName.font = .systemFont(ofSize: 16, weight: .regular)
        schoolName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(schoolName)
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.titleLabel?.font = .systemFont(ofSize: 11, weight: .regular)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.layer.cornerRadius = 10
        logoutButton.backgroundColor = UIColor(red: 0.988, green: 0.658, blue: 0.556, alpha: 1.0)
        view.addSubview(logoutButton)
        
        spacesLabel.text = "Your Spaces"
        spacesLabel.textColor = UIColor(red: 0.45, green: 0.24, blue: 0.79, alpha: 1.0)
        spacesLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        spacesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spacesLabel)
        
//        let profileLayout = UICollectionViewFlowLayout()
//        profileLayout.minimumLineSpacing = 16
//        profileLayout.minimumInteritemSpacing = 98
//        profileLayout.scrollDirection = .vertical
        

//        profileTableView.backgroundColor = UIColor(red: 1, green: 0.99, blue: 0.96, alpha: 1)
//        profileTableView.tintColor = UIColor(red: 1, green: 0.99, blue: 0.96, alpha: 1)
//        profileTableView.separatorColor = UIColor(red: 1, green: 0.99, blue: 0.96, alpha: 1)
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: profileReuseIdentifier)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.allowsSelection = false
        view.addSubview(profileTableView)
        
        setupConstraints()
//        getSpaces()
                
    }
    
    func setupConstraints() {
        //titleLabel
        
        //ProfileBackground
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leftAnchor.constraint(equalTo: view.leftAnchor),
            background.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26)
        ])
        
        //profileImage
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21)
        ])
        
        //gradientColorView
        NSLayoutConstraint.activate([
            gradientColorView.widthAnchor.constraint(equalToConstant: 390),
            gradientColorView.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        //profileName
        NSLayoutConstraint.activate([
            profileName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 7)
        ])
        
        //schoolName
        NSLayoutConstraint.activate([
            schoolName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            schoolName.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 7)
        ])
        
        //logoutButton
        NSLayoutConstraint.activate([
            logoutButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            logoutButton.widthAnchor.constraint(equalToConstant: 67),
            logoutButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        //spacesLabel
        NSLayoutConstraint.activate([
            spacesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            spacesLabel.topAnchor.constraint(equalTo: gradientColorView.bottomAnchor, constant: 42)
        ])
        
        //profileCollectionView
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: spacesLabel.bottomAnchor, constant: 10),
            profileTableView.widthAnchor.constraint(equalToConstant: 354),
            profileTableView.heightAnchor.constraint(equalToConstant: 400),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 18)
        ])
        
    }
    
//    func getSpaces(){
//        NetworkManager.getBookingsofaUser(token: tokenabc) { response in
//            self.bookings = response
//        }
//    }
}

extension ProfileViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = profileTableView.dequeueReusableCell(withIdentifier: profileReuseIdentifier, for: indexPath) as? ProfileTableViewCell {
            cell.profileConfigure(profile: bookings[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookings.remove(at: indexPath.row)
            profileTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
}

extension ProfileViewController: profileTokenDelegate{
    func changeProfileToken(token: String) {
        tokenabc = token
        print(tokenabc!)
    }
    
    
}

