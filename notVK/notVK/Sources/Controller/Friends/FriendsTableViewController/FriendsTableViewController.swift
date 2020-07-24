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

    var friendsContainer: [FriendItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        
        RealmOperations.shared.fetchFriendsFromRealm()
        TableUpdateService.shared.configureFriendRealmNotifications(forTable: self.tableView)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let uFriendsContainer = friendsContainer else { return 1 }
        return uFriendsContainer.count
    }

    override func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as? FriendsTableViewCell
        
        guard let uCell = cell, let uFriendsContainer = friendsContainer else {
            print("There are some errors with reuse cell")
            return UITableViewCell()
        }
        

        let currentFriend = uFriendsContainer[indexPath.row]
        let fullName = currentFriend.lastName + " " + currentFriend.firstName

        let uPhotoURL = URL(string: (currentFriend.friendPhoto100) ?? "")
         
        uCell.configure(with: fullName, friendPhotoURL: uPhotoURL)
        return uCell
        
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
            if let uFriendsContainer = friendsContainer {
                tempUsers = uFriendsContainer.filter{ $0.lastName.lowercased().contains(text)}
            }
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
