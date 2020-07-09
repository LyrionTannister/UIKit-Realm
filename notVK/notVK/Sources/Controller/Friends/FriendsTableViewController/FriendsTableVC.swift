//
//  FriendsTableViewController.swift
//  notVK
//
//  Created by Roman on 31.03.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {

    @IBOutlet private weak var searchTextField: UITextField!

    var friendsContainer = [FriendItem]()
    private var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFriends()

        // MARK: - Table view properties

        self.clearsSelectionOnViewWillAppear = false
        
    }

    private func fetchFriends() {
        
        VKRequestService.loadFriends { result in
            switch result {
            case .success:
                self.fetchFriendsFromRealm()
            case .failure(let error):
                self.fetchFriendsFromRealm()
                print(error)
            }
        }
        
    }

    private func fetchFriendsFromRealm() {
        guard let friendsFromRealm = RealmRequestService.shared.retrieveObjects(FriendItem.self) else { return }
        self.friendsContainer = friendsFromRealm
            self.configureRealmNotifications()
        }

        private func configureRealmNotifications() {
            
            guard let realm = try? Realm() else { return }
            token = realm.objects(FriendItem.self).observe({ [weak self] changes in
                switch changes {
                case .initial:
                    self?.tableView.reloadData()
                case .update(_,
                             deletions: let deletions,
                             insertions: let insertions,
                             modifications: let modifications):
                    self?.tableView.beginUpdates()
                    self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                               with: .automatic)
                    self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                               with: .automatic)
                    self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                               with: .automatic)
                    self?.tableView.endUpdates()
                case .error(let error):
                    fatalError(error.localizedDescription)
                }
            })
            
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsContainer.count
    }

    override func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTableViewCell

        let currentFriends = friendsContainer[indexPath.row]
        cell.myFriendLabel.text = currentFriends.lastName + " " + currentFriends.firstName
        
        if let photoURL = URL(string: (currentFriends.photo100)!) {
            cell.shadowLayer.image.image = UIImage(data: try! Data(contentsOf: photoURL as URL))
        }
        return cell
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "clickToDetail" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let imagesVC = segue.destination as! FriendsCollectionViewController
            }
        }
        
    }

    func getSortedUsers(searchText: String?) -> [Character:[FriendItem]]?{
        
        var tempUsers: [FriendItem]?
        if let text = searchText?.lowercased(), searchText != "" {
            tempUsers = friendsContainer.filter{ $0.lastName.lowercased().contains(text)}
        } else {
            tempUsers = friendsContainer
        }
        if let isUsersExists = tempUsers {
            let sortedUsers = Dictionary.init(grouping: isUsersExists) { $0.lastName.lowercased().first! }.mapValues{ $0.sorted{ $0.lastName.lowercased() < $1.lastName.lowercased() } }
            return sortedUsers
        } else {
            return nil
        }
        
    }
    
    @IBAction private func cancelButtonPressed(_ sender: Any) {
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
        searchTextField.endEditing(true)
        tableView.reloadData()
    }
}

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //TODO: Needed search realization

        tableView.reloadData()
              
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}