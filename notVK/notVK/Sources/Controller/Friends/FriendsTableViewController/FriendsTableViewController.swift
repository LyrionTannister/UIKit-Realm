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

    private var friendsContainer: [FriendItem]?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        
        RealmOperations.shared.fetchFriendsFromRealm()
        fetchFriendsFromRealm()
        
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
    
}

extension FriendsTableViewController {
    
    //MARK: fetchFriendsFromRealm
    private func fetchFriendsFromRealm() {
        
        guard let friendsFromRealm = RealmRequestService.shared.retrieveObjects(FriendItem.self) else { return }
        self.friendsContainer = friendsFromRealm
        self.configureFriendRealmNotifications()
        
    }
    
    //MARK: configureFriendRealmNotifications
    private func configureFriendRealmNotifications() {
        
        guard let realm = try? Realm() else { return }
        token = realm.objects(FriendItem.self).observe({ changes in
            switch changes {
            case .initial:
                self.tableView.reloadData()
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                  with: .automatic)
                self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                  with: .automatic)
                self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                  with: .automatic)
                self.tableView.endUpdates()
            case .error(let error):
                fatalError(error.localizedDescription)
            }
        })
        
    }
    
}
