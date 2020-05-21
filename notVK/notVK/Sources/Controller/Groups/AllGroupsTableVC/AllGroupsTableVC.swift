//
//  AllGroupsTableViewController.swift
//  notVK
//
//  Created by Roman on 02.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {

    struct Section <T> {
        var title: String
        var items: [T]
    }

    let allGroups = GroupFactory.makeGroups()
    var groupsSection = [Section<Group>]()
    var groupsDictionary = [Character:[Group]]()
    var firstLetters: [Character] {
        get {
            groupsDictionary.keys.sorted()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        groupsDictionary = self.getSortedGroups(searchText: nil)
    
        let groupsFinder = Dictionary.init(grouping: allGroups) {
            $0.name.prefix(1)
        }
    
        groupsSection = groupsFinder.map {Section(title: String($0.key), items: $0.value)}

        groupsSection.sort {$0.title < $1.title}
        
        //groupsSection.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupsSection.count
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupsSection.map {$0.title}
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewForHeaderInSection = CustomSectionDesign()
            viewForHeaderInSection.label.text =  String(firstLetters[section].uppercased())
        return viewForHeaderInSection
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupsSection[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsSection[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsTableViewCell

        let group = groupsSection[indexPath.section].items[indexPath.row]
        cell.friendName.text = group.name
        cell.friendPhoto.image.image = UIImage(named: group.fotoPath)
        return cell
    }

    func getSortedGroups(searchText: String?) -> [Character:[Group]]{
        var tempGroup: [Group]
        if let text = searchText?.lowercased(), searchText != "" {
            tempGroup = allGroups.filter{ $0.name.lowercased().contains(text)}
        } else {
            tempGroup = allGroups
        }
        let sortedGroups = Dictionary.init(grouping: tempGroup) { $0.name.lowercased().first! }
            .mapValues{ $0.sorted{ $0.name.lowercased() < $1.name.lowercased() } }
        return sortedGroups
    }
    // MARK: - Navigation
}
