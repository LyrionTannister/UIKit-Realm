//
//  GroupsTableViewController.swift
//  notVK
//
//  Created by Roman on 02.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    var groupResponse: GroupResponse? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        
        VKRequestDelegate.loadGroups { [weak self] (result) in
            switch result {
            case .success(let groupResponse):
                self?.groupResponse = groupResponse
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
        return groupResponse?.response.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsViewCell
        //cell.imageRoundedShadowed.image.image = UIImage(named: group.name)
        cell.myGroupLabel.text = groupResponse?.response.items[indexPath.row].name ?? ""
        if let photoURL = URL(string: (groupResponse?.response.items[indexPath.row].photo50)!) {
            cell.imageRoundedShadowed.image.image = UIImage(data: try! Data(contentsOf: photoURL as URL))
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let alert = UIAlertController(
            title: "Группа",
            message: "Ты выбрал строку \(indexPath.row)",
            preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
    
        alert.addAction(action)
        present(alert, animated: true)
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            myGroups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

    // MARK: - Navigation
    @IBAction func addGroupUnwindAction(unwindSegue: UIStoryboardSegue){
        if unwindSegue.identifier == "addGroup" {
            guard let allGroupsController = unwindSegue.source as? AllGroupsTableViewController else {
                return
            }
//            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
//                let group = allGroupsController.allGroups[indexPath.row]
//                if !myGroups.contains(group){
//                    myGroups.append(group)
//                    tableView.reloadData()
//                }
//            }
        }
    }
}
