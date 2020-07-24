//
//  TableUpdateService.swift
//  notVK
//
//  Created by Roman on 24.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit
import RealmSwift


class TableUpdateService {
    
    static let shared = TableUpdateService()
    
    private init() {}
    
    private var token: NotificationToken?
    
    func configureFriendRealmNotifications(forTable table: UITableView) {
        
        guard let realm = try? Realm() else { return }
        token = realm.objects(FriendItem.self).observe({ [weak table] changes in
            switch changes {
            case .initial:
                table?.reloadData()
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                table?.beginUpdates()
                table?.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                  with: .automatic)
                table?.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                  with: .automatic)
                table?.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                  with: .automatic)
                table?.endUpdates()
            case .error(let error):
                fatalError(error.localizedDescription)
            }
        })
        
    }
}
