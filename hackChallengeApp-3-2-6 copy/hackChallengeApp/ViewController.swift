//
//  ViewController.swift
//  hackChallengeApp
//
//  Created by user227825 on 11/23/22.
//

import UIKit
import Lottie

class ViewController: UIViewController{
    
    
    let tokenPlaceholder = UILabel()
    
    let passwordLabel = UILabel()
    let emailLabel = UILabel()
    let sloganLabel = UILabel()
    let sloganDesc = UILabel()
//    let button1 = UIButton()
    let button1 = GradientButton(frame: CGRect(x: 0, y: 0, width: 245, height: 45))
    let button2 = UIButton()
    var logoApp: LottieAnimationView!
//    let logoApp = LottieAnimationView!
//    let email = UITextField()
    let email = LoginScreenPaddedTextField()
//    let password = UITextField()
    let password = LoginScreenPaddedTextField()
    let line1 = UIView()
    let line2 = UIView()
    var emailList : [String] = []
    var passwordList : [String] = []
    
    var delegate: passTokenDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(delegate: passTokenDelegate){
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        logoApp = .init(name: "login_animation1")
        logoApp.translatesAutoresizingMaskIntoConstraints = false
        logoApp.loopMode = .loop
        logoApp.backgroundBehavior = .pauseAndRestore
        view.addSubview(logoApp)
        logoApp.play()
        
        sloganLabel.text = "YourSpace"
        sloganLabel.font = .systemFont(ofSize: 36, weight: .semibold)
        sloganLabel.textColor = UIColor(red: 0.3294, green: 0.239, blue: 0.721, alpha: 1.0)
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sloganLabel)
        
        sloganDesc.text = "Study space booking made easy."
        sloganDesc.font = .systemFont(ofSize: 20, weight: .regular)
        sloganDesc.textColor = UIColor(red: 0.988, green: 0.6588, blue: 0.5568, alpha: 1.0)
        sloganDesc.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sloganDesc)
        
        
//        let emailPlaceholderText = NSMutableAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.4549, green: 0.333, blue: 0.9647, alpha: 1.0)])
        
//        email.attributedPlaceholder = emailPlaceholderText
        self.email.delegate = self
        email.textColor = UIColor(red: 0.3294, green: 0.239, blue: 0.721, alpha: 1.0)
//        email.backgroundColor = .black
        email.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(email)
        
//        let passwordPlaceholderText = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.4549, green: 0.333, blue: 0.9647, alpha: 1.0)])
        
        emailLabel.text = "Email"
        emailLabel.textColor = UIColor(red: 0.45, green: 0.33, blue: 0.96, alpha: 1.0)
        emailLabel.font = .systemFont(ofSize: 18,weight: .regular)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(emailLabel, at: 2)
        
        passwordLabel.text = "Password"
        passwordLabel.textColor = UIColor(red: 0.45, green: 0.33, blue: 0.96, alpha: 1.0)
        passwordLabel.font = .systemFont(ofSize: 18, weight: .regular)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(passwordLabel, at: 2)
        
//        password.attributedPlaceholder = passwordPlaceholderText
        self.password.delegate = self
        password.textColor = UIColor(red: 0.3294, green: 0.239, blue: 0.721, alpha: 1.0)
//        password.textColor = .black
        password.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(password)
        
        line1.backgroundColor = UIColor(red: 0.764, green: 0.6667, blue: 0.921, alpha: 1.0)
        line1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(line1)
        
        line2.backgroundColor = UIColor(red: 0.764, green: 0.6667, blue: 0.921, alpha: 1.0)
        line2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(line2)
        
        button1.backgroundColor = UIColor(red: 0.988, green: 0.6588, blue: 0.5568, alpha: 1.0)
        button1.setTitle("LOGIN", for: .normal)
        button1.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.layer.cornerRadius = 18
        button1.clipsToBounds = true
        button1.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(button1)
        
        button2.setTitle("Register", for: .normal)
        button2.setTitleColor(UIColor(red: 0.4588, green: 0.337, blue: 0.968, alpha: 1.0), for: .normal)
        button2.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.addTarget(self, action: #selector(pushView), for: .touchUpInside)
        view.addSubview(button2)
        
        
        // self.delegate = BookingPresentViewController()
        
        setupConstraints()
    }
    
    @objc func login(){
        NetworkManager.loginUser(email: email.text ?? " ", password: password.text ?? " ") { token in
            self.tokenPlaceholder.text = token
            self.delegate?.changeToken(token: token)
            self.presentTabBar()
        }
    }
    
    func setupConstraints() {
        //logoApp
        NSLayoutConstraint.activate([
            logoApp.heightAnchor.constraint(equalToConstant: 317),
            logoApp.widthAnchor.constraint(equalToConstant: 370),
            logoApp.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            logoApp.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10)
        ])
        
        //sloganLabel
        NSLayoutConstraint.activate([
            sloganLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sloganLabel.topAnchor.constraint(equalTo: logoApp.bottomAnchor, constant: 40)
        ])
        
        //sloganDesc
        NSLayoutConstraint.activate([
            sloganDesc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sloganDesc.topAnchor.constraint(equalTo: sloganLabel.bottomAnchor, constant: 10)
        ])
        
        //emaillabel
        
        NSLayoutConstraint.activate([
        
            emailLabel.topAnchor.constraint(equalTo: sloganDesc.bottomAnchor,constant: 40),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 53)
            
        ])
        
        //email
        NSLayoutConstraint.activate([
            email.widthAnchor.constraint(equalToConstant: 286),
            email.heightAnchor.constraint(equalToConstant: 42),
            email.topAnchor.constraint(equalTo: sloganDesc.bottomAnchor, constant: 50),
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53)
        ])
        
        //line1
        NSLayoutConstraint.activate([
            line1.widthAnchor.constraint(equalToConstant: 286),
            line1.heightAnchor.constraint(equalToConstant: 1),
            line1.topAnchor.constraint(equalTo: email.bottomAnchor),
            line1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
        
        //password label
        NSLayoutConstraint.activate([
        
            passwordLabel.topAnchor.constraint(equalTo: line1.bottomAnchor,constant: 25),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 53)
        
        ])
        
        //password
        NSLayoutConstraint.activate([
            password.widthAnchor.constraint(equalToConstant: 286),
            password.heightAnchor.constraint(equalToConstant: 42),
            password.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 36),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53)
        ])
        
        //line2
        NSLayoutConstraint.activate([
            line2.widthAnchor.constraint(equalToConstant: 286),
            line2.heightAnchor.constraint(equalToConstant: 1),
            line2.topAnchor.constraint(equalTo: password.bottomAnchor),
            line2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
        
        //button1
        NSLayoutConstraint.activate([
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.widthAnchor.constraint(equalToConstant: 245),
            button1.heightAnchor.constraint(equalToConstant: 45),
            button1.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 45)
        ])

        //button2
        NSLayoutConstraint.activate([
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.widthAnchor.constraint(equalToConstant: 63),
            button2.heightAnchor.constraint(equalToConstant: 19),
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 14)
        ])
        
        
    }
    
    func presentTabBar(){
        
        email.text = email.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        password.text = password.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        
        if email.text != nil && password.text != nil && email.text != "" && password.text != "" {
                    if let token = tokenPlaceholder.text{
                        
                        let tabBarItems = UITabBarController()
                        let reserveVC = ReserveViewController()
                        let homeVC = HomeViewController(delegate: reserveVC)
                        let profileVC = ProfileViewController()
                        //setting up tabBarItems
                        tabBarItems.tabBar.tintColor = UIColor(red: 73/255, green: 23/255, blue: 155/255, alpha: 1)
                        tabBarItems.tabBar.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                        tabBarItems.tabBar.unselectedItemTintColor = .black
                        //        tabBarItems.tabBar.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1).cgColor
                        //        homeVC.title = "Home"
                        //        reserveVC.title = "List"
                        //        profileVC.title = "Profile"
                        
                        
                        tabBarItems.setViewControllers([homeVC,reserveVC,profileVC], animated: true)
                        
                        guard let items = tabBarItems.tabBar.items else{
                            return
                        }
                        let images = ["homeicon", "reservepage", "profileicon" ]
                        
                        for x in 0..<items.count {
                            items[x].image = UIImage(named: images[x])
                        }
                        tabBarItems.tabBar.items![0].imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -20, right: 0)
                        tabBarItems.tabBar.items![1].imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -20, right: 0)
                        tabBarItems.tabBar.items![2].imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -20, right: 0)
                        tabBarItems.modalPresentationStyle = .fullScreen
                        tabBarItems.modalTransitionStyle = .flipHorizontal
                        //        tabBarItems.modalTransitionStyle = .partialCurl
                        tabBarItems.selectedIndex = 1
                        tabBarItems.selectedIndex = 0
                        present(tabBarItems,animated: true)
                    }
                }
        
        
        else{
            print(":((")
        }
    }
    
    @objc func pushView() {
        navigationController?.pushViewController(PushViewController(inputDelegate: self), animated: true)
    }
}

extension ViewController : ChangeLoginInfoDelegate {
    func changePassword(str: String) {
        passwordList.append(str)
    }
    
    func changeEmail(str: String) {
        emailList.append(str)
    }
    
    
}

extension ViewController: UITextFieldDelegate{
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

protocol passTokenDelegate: UIViewController{
    func changeToken(token:String)
}


