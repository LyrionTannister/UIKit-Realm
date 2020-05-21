//
//  FriendsTableViewController.swift
//  notVK
//
//  Created by Roman on 31.03.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    @IBOutlet weak var searchTextField: UITextField!

    var friendResponse: FriendResponse? = nil

    struct Section <T> {
        var title: String
        var items: [T]
    }

    var friendsSection = [Section<FriendItem>]()
    var friendsDictionary : [Character:[FriendItem]]?
    var firstLetters: [Character]? {
        get {
            friendsDictionary?.keys.sorted() ?? nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        friendsDictionary = self.getSortedUsers(searchText: nil)
        //sortedFriends(friends: allMyFriends)
        //let friendsFinder : [FriendItem]? = Dictionary.init(grouping: friendResponse?.response.items ?? nil) { $0.last_name.prefix(1)}
        //friendsSection = friendsFinder.map {Section(title: String($0.key), items: $0.value)}
        //friendsSection.sort {$0.title < $1.title}

        // MARK: - Table view properties

        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        VKRequestDelegate.loadFriends { [weak self] (result) in
            switch result {
            case .success(let friendResponse):
                self?.friendResponse = friendResponse
                self?.tableView.reloadData()
            case .failure(let error):
                print("error: ", error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendResponse?.response.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTableViewCell

        //let friends = friendsSection[indexPath.section].items[indexPath.row]

        //cell.myFriendLabel.text = friends.firstName + " " + friends.lastName
        //cell.shadowLayer.image.image = UIImage(named: friends.fotoPath)
        
        cell.myFriendLabel.text = (friendResponse?.response.items[indexPath.row].lastName ?? "") + " " + (friendResponse?.response.items[indexPath.row].firstName ?? "")

        if let photoURL = URL(string: (friendResponse?.response.items[indexPath.row].photo100)!) {
            cell.shadowLayer.image.image = UIImage(data: try! Data(contentsOf: photoURL as URL))
        }
        return cell
    }

//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let viewForHeaderInSection = CustomSectionDesign()
//        viewForHeaderInSection.label.text = String(firstLetters[section].uppercased())
//        return viewForHeaderInSection
//    }

//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return friendsSection.map {$0.title}
//    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return friendsSection[section].title
//    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clickToDetail" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let imagesVC = segue.destination as! FriendsCollectionViewController
                //imagesVC.friendsPhotos = friendsSection[indexPath.section].items[indexPath.row].photos
            }
        }
    }

    func getSortedUsers(searchText: String?) -> [Character:[FriendItem]]?{
        var tempUsers: [FriendItem]?
        if let text = searchText?.lowercased(), searchText != "" {
            tempUsers = friendResponse?.response.items.filter{ $0.lastName.lowercased().contains(text)}
        } else {
            tempUsers = friendResponse?.response.items
        }
        if let isUsersExists = tempUsers {
            let sortedUsers = Dictionary.init(grouping: isUsersExists) { $0.lastName.lowercased().first! }.mapValues{ $0.sorted{ $0.lastName.lowercased() < $1.lastName.lowercased() } }
            return sortedUsers
        } else {
            return nil
        }
    }

//    func sortedFriends(friends: [User]) {
//        let sortedUsers = Dictionary.init(grouping: friends) {$0.lastName.lowercased().first!}
//            .mapValues{ $0.sorted{$0.lastName.lowercased() < $1.lastName.lowercased() } }
//
//        friendsDictionary = sortedUsers
//    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
                        self.searchTextField.alpha = 0
                        self.view.layoutIfNeeded()
        })
        searchTextField.text = ""
        //sortedFriends(friends: allMyFriends)
        searchTextField.endEditing(true)
        tableView.reloadData()
    }
}
