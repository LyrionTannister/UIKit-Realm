//
//  ExtFindFriend.swift
//  notVK
//
//  Created by Roman on 13.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

//        let friendsDictionary = Dictionary.init(grouping: allMyFriends.filter{(user) -> Bool in return searchText
//            .isEmpty ? true : user.lastName.lowercased()
//                .contains(searchText.lowercased())
//                ||
//                user.firstName.lowercased()
//                    .contains(searchText.lowercased())
//        }) {
//            $0.firstName.prefix(1)
//        }
//
//        friendsSection = friendsDictionary.map {Section(title: String($0.key),items: $0.value)}

        //friendsSection.sort {$0.title < $1.title}

        tableView.reloadData()
              
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
