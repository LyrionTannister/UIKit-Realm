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
        
//        RealmOperations.shared.fetchFriendsFromRealm()
//        loadFriendsFromRealm()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let uFriendsContainer = friendsContainer else { return 0 }
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
    
}

extension FriendsTableViewController {
    
    //MARK: loadFriendsFromRealm
    private func loadFriendsFromRealm() {
        
        guard let friendsFromRealm = RealmRequestService.shared.retrieveObjects(FriendItem.self) else { return }
        self.friendsContainer = friendsFromRealm
        //self.configureFriendRealmNotifications()
        
    }
    
    //MARK: configureFriendRealmNotifications
    private func configureFriendRealmNotifications() {
        
        guard let realm = try? Realm() else { return }
        self.token = realm.objects(FriendItem.self).observe({ [weak self] changes in
            guard let selfTableView = self?.tableView else { return }
            switch changes {
            case .initial:
                selfTableView.reloadData()
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                selfTableView.beginUpdates()
                selfTableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                  with: .automatic)
                selfTableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                  with: .automatic)
                selfTableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                  with: .automatic)
                selfTableView.endUpdates()
            case .error(let error):
                fatalError(error.localizedDescription)
            }
        })
        
    }
    
}
