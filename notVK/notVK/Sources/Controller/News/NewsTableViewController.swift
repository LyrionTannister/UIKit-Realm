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

    let vkNewsService = VKNewsService()

    override func loadView() {
        super.loadView()
        self.view = NewsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews()
    }
    
    func fetchNews () -> Void {
        vkNewsService.loadNews { result in
            switch result {
            case .success(let newsResponse):
                self.view().newsTableView.news = newsResponse.items
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    func view() -> NewsView {
        return self.view as! NewsView
    }
}
