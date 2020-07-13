//
//  FriendsTableViewCell.swift
//  notVK
//
//  Created by Roman on 02.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet private weak var shadowLayer: ImageRoundedShadowed!
    @IBOutlet private weak var myFriendLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with friendName: String, friendPhotoURL: URL?) {
        myFriendLabel.text = friendName
        if let uFriendPhotoURL = friendPhotoURL {
            let uFriendPhoto = UIImage(data: try! Data(contentsOf: uFriendPhotoURL as URL))
            shadowLayer.image.image = uFriendPhoto
        }
    }
    
}
