//
//  AllGroupsTableViewController.swift
//  notVK
//
//  Created by Roman on 02.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {

    var findedGroupsContainer: [GroupItem]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let uFindedGroupsContainer = findedGroupsContainer else { return 1 }
        
        return uFindedGroupsContainer.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as? AllGroupsTableViewCell

        guard let uCell = cell, let uFindedGroupsContainer = findedGroupsContainer else {
            return AllGroupsTableViewCell() }
        
        let currentGroup = uFindedGroupsContainer[indexPath.row]
        uCell.configure(with: currentGroup.name)
        return uCell
    }
}
