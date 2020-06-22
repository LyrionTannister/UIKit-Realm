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

    let networkService = NetworkingService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getNews(onComplete: { (news) in
            print(news)
            self.view().newsTableView.news = news
            self.view().newsTableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
}
