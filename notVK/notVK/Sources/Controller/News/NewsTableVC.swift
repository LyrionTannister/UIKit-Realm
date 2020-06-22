//
//  NewsTableVC.swift
//  notVK
//
//  Created by Roman on 22.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit
import RealmSwift

class NewsTableViewController: UITableViewController {

    let networkService = VKRequestDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNews()
    }

    private func fetchNews() {
        VKRequestDelegate.loadNews { result in
            switch result {
            case .success:
                self.fetchNews()
                //self.fetchNewsFromRealm()
            case .failure(let error):
                self.fetchNews()
                //self.fetchNewsFromRealm()
                print(error)
            }
        }
    }

//    private func fetchNewsFromRealm() {
//        guard let friendsFromRealm = RealmRequestDelegate.shared.retrieveObjects(NewsItem.self) else { return }
//        self.view().newsTableView.news = friendsFromRealm
//            self.configureRealmNotifications()
//        }
//
//        private func configureRealmNotifications() {
//            guard let realm = try? Realm() else { return }
//            token = realm.objects(FriendItem.self).observe({ [weak self] changes in
//                switch changes {
//                case .initial:
//                    self?.tableView.reloadData()
//                case .update(_,
//                             deletions: let deletions,
//                             insertions: let insertions,
//                             modifications: let modifications):
//                    self?.tableView.beginUpdates()
//                    self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
//                                               with: .automatic)
//                    self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
//                                               with: .automatic)
//                    self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
//                                               with: .automatic)
//                    self?.tableView.endUpdates()
//                case .error(let error):
//                    fatalError(error.localizedDescription)
//                }
//            })
//        }
    
}
