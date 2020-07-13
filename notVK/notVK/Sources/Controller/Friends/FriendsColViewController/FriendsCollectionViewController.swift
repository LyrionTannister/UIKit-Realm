//
//  FriendsCollectionViewController.swift
//  notVK
//
//  Created by Roman on 02.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class FriendsCollectionViewController: UICollectionViewController {

    var friendsPhotos: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let uFriendsPhotos = friendsPhotos else { return 1 }
        return uFriendsPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoCell", for: indexPath) as? FriendsCollectionViewCell
        guard let uCell = cell, let uFriendPhotoImage = friendsPhotos else {
            print("There are some errors with reuse cell")
            return UICollectionViewCell()
        }
        
        let friendPhotoImage = UIImage(named: uFriendPhotoImage[indexPath.row])
        uCell.configure(with: friendPhotoImage)
        return uCell
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(
            alongsideTransition: { _ in self.collectionView.collectionViewLayout.invalidateLayout() },
            completion: { _ in }
        )
    }
    // MARK: UICollectionViewDelegate

}
