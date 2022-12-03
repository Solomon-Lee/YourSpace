//
//  PushViewController.swift
//  hackChallengeApp
//
//  Created by user227825 on 11/26/22.
//

import UIKit


class PushViewController: UIViewController {
    
    
    let emailLabel = UILabel()
    let registerWhiteBox = UIView()
    let backgroundLines = UIImageView()
    let gradidentBackground = RegisterGradientView(frame: UIScreen.main.bounds)
    weak var delegate: ChangeLoginInfoDelegate?
//    let emailText = UITextField()
    let passwordLabel = UILabel()
    let emailText = paddedTextField()
    let welcomeLabel = UILabel()
    let welcomeDesc = UILabel()
    let line1 = UIView()
//    let passwordText = UITextField()
    let passwordText = paddedTextField()
    let line2 = UIView()
    let createAccount = UIButton()
    let orLabel = UILabel()
    let googleButton = UIButton()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(inputDelegate : ChangeLoginInfoDelegate) {
        delegate = inputDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        registerWhiteBox.backgroundColor = .white
        registerWhiteBox.translatesAutoresizingMaskIntoConstraints = false
        registerWhiteBox.clipsToBounds = true
        registerWhiteBox.layer.cornerRadius = 28
        view.insertSubview(registerWhiteBox, at: 2)
        
        backgroundLines.image = UIImage(named: "loginPageBackground")
        backgroundLines.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundLines, at: 0)
        
        gradidentBackground.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(gradidentBackground, at: 0)
        
        welcomeLabel.font = .systemFont(ofSize: 36, weight: .semibold)
        welcomeLabel.text = "Welcome!"
        welcomeLabel.textColor = .white
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(welcomeLabel)
        view.insertSubview(welcomeLabel, at: 3)
        
        welcomeDesc.font = .systemFont(ofSize: 20, weight: .regular)
        welcomeDesc.text = "To get started, please create an account below"
        welcomeDesc.numberOfLines = 2
        welcomeDesc.textColor = UIColor(red: 1.0, green: 1, blue: 1, alpha: 1.0)
        welcomeDesc.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(welcomeDesc)
        view.insertSubview(welcomeDesc, at: 3)
        
//        let emailPlaceholderText = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.62, green: 0.52, blue: 0.95, alpha: 1.0)])
//        emailText.attributedPlaceholder = emailPlaceholderText
        emailLabel.text = "Email"
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = UIColor(red: 0.62, green: 0.52, blue: 0.95, alpha: 1.0)
        emailLabel.font = .systemFont(ofSize: 18, weight: .regular)
        view.insertSubview(emailLabel, at: 3)
        self.emailText.delegate = self
        emailText.translatesAutoresizingMaskIntoConstraints = false
//        emailText.textColor = UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1)
//        view.addSubview(emailText)
        emailText.textColor = UIColor(red: 0.3294, green: 0.239, blue: 0.721, alpha: 1.0)
        view.insertSubview(emailText, at: 3)
        
        line1.backgroundColor = UIColor(red: 0.78, green: 0.69, blue: 0.92, alpha: 1.0)
        line1.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(line1)
        view.insertSubview(line1, at: 3)
        
//        let passwordPlaceholderText = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1.0)])
//        passwordText.attributedPlaceholder = passwordPlaceholderText
        passwordLabel.text = "Password"
        passwordLabel.textColor = UIColor(red: 0.62, green: 0.52, blue: 0.95, alpha: 1.0)
        passwordLabel.font = .systemFont(ofSize: 18, weight: .regular)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(passwordLabel, at: 3)
        self.passwordText.delegate = self
        passwordText.translatesAutoresizingMaskIntoConstraints = false
//        passwordText.textColor = UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1)
        passwordText.textColor = UIColor(red: 0.3294, green: 0.239, blue: 0.721, alpha: 1.0)
//        view.addSubview(passwordText)
        view.insertSubview(passwordText, at: 3)
        
        line2.backgroundColor = UIColor(red: 0.78, green: 0.69, blue: 0.92, alpha: 1.0)
        line2.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(line2)
        view.insertSubview(line2, at: 3)
        
        orLabel.text = "or"
        orLabel.textColor = UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1.0)
        orLabel.font = .systemFont(ofSize: 18, weight: .regular)
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(orLabel, at: 3)
        
        googleButton.setTitle("Connect to Google", for: .normal)
        googleButton.setTitleColor(UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1.0), for: .normal)
        googleButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.layer.cornerRadius = 4
        googleButton.clipsToBounds = true
        googleButton.layer.borderColor = UIColor(red: 0.62, green: 0.51, blue: 0.95, alpha: 1.0).cgColor
        googleButton.layer.borderWidth = 1
        view.insertSubview(googleButton, at: 3)
        
        createAccount.backgroundColor = UIColor(red: 0.99, green: 0.66, blue: 0.56, alpha: 1)
        createAccount.setTitle("Create Account", for: .normal)
        createAccount.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1.0), for: .normal)
        createAccount.translatesAutoresizingMaskIntoConstraints = false
        createAccount.clipsToBounds = true
        createAccount.layer.cornerRadius = 18
        createAccount.addTarget(self, action: #selector(loginInfo), for: .touchUpInside)
//        view.addSubview(createAccount)
        view.insertSubview(createAccount, at: 3)
        
        
        setupConstraints()

    }
    
    func setupConstraints() {
        //welcomeLabel
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 327),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32)
        ])
        
        //emailLabel
        NSLayoutConstraint.activate([
        
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            emailLabel.bottomAnchor.constraint(equalTo: line1.topAnchor,constant: -30)
        
        
        ])
        
        //password label
        NSLayoutConstraint.activate([
        
            passwordLabel.bottomAnchor.constraint(equalTo: line2.topAnchor,constant: -30),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32)
        
        ])
        
        //whitebox
        NSLayoutConstraint.activate([
        
            registerWhiteBox.topAnchor.constraint(equalTo: welcomeDesc.bottomAnchor,constant: 54),
            registerWhiteBox.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            registerWhiteBox.leftAnchor.constraint(equalTo: view.leftAnchor),
            registerWhiteBox.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        ])
        
        //backgroundLines
        NSLayoutConstraint.activate([
        
            backgroundLines.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundLines.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundLines.rightAnchor.constraint(equalTo: view.rightAnchor),
//            backgroundLines.bottomAnchor.constraint(equalTo: welcomeDesc.bottomAnchor,constant: 54)
        
        ])
        
        //welcomeDesc
        NSLayoutConstraint.activate([
            welcomeDesc.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 14),
            welcomeDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            welcomeDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62)
        ])
        
        //emailText
        NSLayoutConstraint.activate([
            emailText.topAnchor.constraint(equalTo: registerWhiteBox.topAnchor, constant: 37),
            emailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailText.widthAnchor.constraint(equalToConstant: 326),
            emailText.heightAnchor.constraint(equalToConstant: 43)
        ])
        
        //line1
        NSLayoutConstraint.activate([
            line1.widthAnchor.constraint(equalToConstant: 326),
            line1.heightAnchor.constraint(equalToConstant: 1),
            line1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            line1.topAnchor.constraint(equalTo: registerWhiteBox.topAnchor,constant: 90)
        ])
        
        //passwordText
        NSLayoutConstraint.activate([
            passwordText.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 10),
            passwordText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordText.widthAnchor.constraint(equalToConstant: 326),
            passwordText.heightAnchor.constraint(equalToConstant: 43)
        ])
        
        //line2
        NSLayoutConstraint.activate([
            line2.widthAnchor.constraint(equalToConstant: 326),
            line2.heightAnchor.constraint(equalToConstant: 1),
            line2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            line2.topAnchor.constraint(equalTo: line1.bottomAnchor,constant: 60)
        ])
        
        //orLabel
        NSLayoutConstraint.activate([
            orLabel.topAnchor.constraint(equalTo: line2.bottomAnchor,constant: 18),
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])

        //googleButton
        NSLayoutConstraint.activate([
            googleButton.widthAnchor.constraint(equalToConstant: 326),
            googleButton.heightAnchor.constraint(equalToConstant: 41),
            googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor,constant: 18),

        ])

        //createAccount
        NSLayoutConstraint.activate([
            createAccount.widthAnchor.constraint(equalToConstant: 245),
            createAccount.heightAnchor.constraint(equalToConstant: 45),
            createAccount.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 123),
            createAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func registerUser(){
        NetworkManager.createUser(email: emailText.text ?? "", password: passwordText.text ?? "") { token in
            print(token)
        }
    }
    
    @objc func loginInfo() {
        delegate?.changeEmail(str: emailText.text ?? "No email inputted")
        delegate?.changePassword(str: passwordText.text ?? "No password inputted")
        if (emailText.text == "" && passwordText.text == "") {
            let alert = UIAlertController(title: "Multiple descriptions are missing", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if (emailText.text == "") {
            let alert = UIAlertController(title: "The username is missing", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if (passwordText.text == "") {
            let alert = UIAlertController(title: "The password is missing", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        registerUser()
    }
    
}

extension PushViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

protocol ChangeLoginInfoDelegate: UIViewController {
    func changeEmail(str: String)
    func changePassword(str: String)
}
