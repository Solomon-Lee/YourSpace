//
//  HomeViewController.swift
//  HackathonApp
//
//  Created by Wei Zheng on 11/24/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let profilepicCircle = UIView()

    let backgroundLines = UIImageView()
    let topBackgroundView  = GradientView(frame: CGRect(x: 0, y: 0, width: 400, height: 234))
    var personName = UILabel()
    var cornellLabel = UILabel()
    var personProfilePic = UIImageView()
//    let roomSearchBar = UISearchBar()
    let lookingLabel = UILabel()
    let spacesLabel = UILabel()
    var spaces: [Spaces] = []
    
    weak var delegate: changeDropdownIndexDelegate?
    
    init(delegate: changeDropdownIndexDelegate){
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //setting up array for spaces
    let classroom = Spaces(name: "Classrooms", pic: "classroom", availableSpace: "13")
    let computerLab = Spaces(name: "Computer Labs", pic: "computerlab", availableSpace: "4")
    let groupStudy = Spaces(name: "Group Study Rooms", pic: "groupstudy", availableSpace: "22")
    let meetingRoom = Spaces(name: "Meeting Rooms", pic: "meetingroom", availableSpace: "12")
    
    var spaceCollectiomView: UICollectionView!
    let spaceReuseIdentifier: String = "spaceReuseIdentifier"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Home"
        view.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.96, alpha: 1)
        
        navigationController?.navigationBar.isTranslucent = false
        

        
        
        //setting up the backgroundline
        
        backgroundLines.image = UIImage(named: "homeAndSpacesBackground")
        backgroundLines.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundLines, at: 1)
        
        
        //setting up the topbackgroundView
        topBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(topBackgroundView, at: 0)
        
        //setting up the personName View
        personName.text = "Hello Jason!"
        personName.font = .systemFont(ofSize: 36, weight: .semibold)
        personName.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        personName.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(personName, at: 2)
        
        //setting up the cornell univeristy label
        cornellLabel.text = "Cornell University"
        cornellLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cornellLabel.translatesAutoresizingMaskIntoConstraints = false
        cornellLabel.font = .systemFont(ofSize: 16,weight: .regular)
        view.insertSubview(cornellLabel, at: 2)
        
        //setting up the personProfile view
        personProfilePic.image = UIImage(named: "Path")
        personProfilePic.translatesAutoresizingMaskIntoConstraints = false
        personProfilePic.clipsToBounds = true
//        personProfilePic.layer.cornerRadius = 30
        view.insertSubview(personProfilePic, at: 3)
        
        //setting up the profilecircle
        profilepicCircle.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        profilepicCircle.translatesAutoresizingMaskIntoConstraints = false
        profilepicCircle.clipsToBounds = false
        profilepicCircle.layer.cornerRadius = 30
        view.insertSubview(profilepicCircle, at: 2)
        
        //setting up the looking label
        lookingLabel.text = "What kind of space are you looking for?"
        lookingLabel.font = .systemFont(ofSize: 16, weight: .regular)
        lookingLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lookingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(lookingLabel, at: 2)
        
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
        
        
        //setting up the explore space label
        spacesLabel.text = "Explore Spaces"
        spacesLabel.font = .systemFont(ofSize: 24,weight: .semibold)
        spacesLabel.textColor = UIColor(red: 0.46, green: 0.34, blue: 0.97, alpha: 1.0)
        spacesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(spacesLabel, at: 1)
        
        //setting up the space collectionView array
        spaces = [classroom,computerLab,groupStudy,meetingRoom]
        
        //setting up the space collectionView
        let spaceLayout = UICollectionViewFlowLayout()
        spaceLayout.minimumLineSpacing = 20
        spaceLayout.minimumInteritemSpacing = 20
        
        spaceCollectiomView = UICollectionView(frame: .zero, collectionViewLayout: spaceLayout)
        
        spaceCollectiomView.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.96, alpha: 1)
        spaceCollectiomView.tintColor = UIColor(red: 1, green: 0.98, blue: 0.96, alpha: 1)
        spaceCollectiomView.register(SpaceCollectionViewCell.self, forCellWithReuseIdentifier: spaceReuseIdentifier)
        spaceCollectiomView.dataSource = self
        spaceCollectiomView.delegate = self
        spaceCollectiomView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(spaceCollectiomView, at: 1)
                
        
        
        //setting up the looking label
        NSLayoutConstraint.activate([
        
        
            lookingLabel.topAnchor.constraint(equalTo: personName.bottomAnchor,constant: 3),
            lookingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30)
        
        
        ])

        
        //setting up the constraints for the background lines
        NSLayoutConstraint.activate([
            backgroundLines.heightAnchor.constraint(equalToConstant: 234),
            backgroundLines.widthAnchor.constraint(equalToConstant: 390),
        ])
        
        //setting up the constraints for topbackgroundview
        NSLayoutConstraint.activate([
            topBackgroundView.heightAnchor.constraint(equalToConstant: 234),
            topBackgroundView.widthAnchor.constraint(equalToConstant: 390),
        ])
        
        //setting up the constraints for personname
        NSLayoutConstraint.activate([
            personName.topAnchor.constraint(equalTo: cornellLabel.bottomAnchor, constant: 47),
            personName.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 28),
        ])
        
        //setting up the cornell label
        NSLayoutConstraint.activate([
            cornellLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 14),
            cornellLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 29),
        ])
        
        //setting up the person profile pic
        NSLayoutConstraint.activate([
            personProfilePic.heightAnchor.constraint(equalToConstant: 20.65),
            personProfilePic.widthAnchor.constraint(equalToConstant: 20.65),
            personProfilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 45),
            personProfilePic.leftAnchor.constraint(equalTo: profilepicCircle.leftAnchor, constant: 19.35),
        ])
        
        //setting up the search bar
        
//        NSLayoutConstraint.activate([
//            roomSearchBar.topAnchor.constraint(equalTo: cornellLabel.bottomAnchor,constant: 35),
//            roomSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 37),
//            roomSearchBar.heightAnchor.constraint(equalToConstant: 47),
//            roomSearchBar.widthAnchor.constraint(equalToConstant: 315),
//        ])
        
        //setting up the explore space
        
        NSLayoutConstraint.activate([
            spacesLabel.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor,constant: 23),
            spacesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 19),
        
        ])
        
        //setting up the space collectinView
        NSLayoutConstraint.activate([
        
            spaceCollectiomView.topAnchor.constraint(equalTo: spacesLabel.bottomAnchor, constant: 16),
            spaceCollectiomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            spaceCollectiomView.widthAnchor.constraint(equalToConstant: 352),
            spaceCollectiomView.heightAnchor.constraint(equalToConstant: 724)
        
        ])
        
        //setting up the profile circle view
        
        NSLayoutConstraint.activate([
            profilepicCircle.heightAnchor.constraint(equalToConstant: 60),
            profilepicCircle.widthAnchor.constraint(equalToConstant: 60),
            profilepicCircle.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 295),
            profilepicCircle.topAnchor.constraint(equalTo: personProfilePic.topAnchor,constant: -19.35)
        ])
        
        
    }
    @objc func testbuttonfunc(){
        modalPresentationStyle = .fullScreen
        present(ReserveViewController(),animated: false)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 166, height: 215)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = spaceCollectiomView.dequeueReusableCell(withReuseIdentifier: spaceReuseIdentifier, for: indexPath) as! SpaceCollectionViewCell
        cell.spaceConfigure(space: spaces[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print(indexPath.row)
        
//        ReserveViewController().roomMenu.selectRow(indexPath.row)
     
        tabBarController?.selectedIndex = 1
        self.delegate?.changeNum(num: indexPath.row+1)
        
        
    }
    
    
}
//protocol ChangedropDownDelegate: UIViewController{
//    func changeDropdownIndex(num: Int)
//
//}


