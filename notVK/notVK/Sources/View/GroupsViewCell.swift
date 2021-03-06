//
//  GroupsViewCell.swift
//  notVK
//
//  Created by Roman on 02.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class GroupsViewCell: UITableViewCell {

    @IBOutlet private weak var myGroupLabel: UILabel!
    @IBOutlet private weak var imageRoundedShadowed: ImageRoundedShadowed!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with groupName: String, groupPhotoURL: URL?) {
        myGroupLabel.text = groupName
        if let uGroupPhotoURL = groupPhotoURL {
            let uGroupPhoto = UIImage(data: try! Data(contentsOf: uGroupPhotoURL as URL))
            imageRoundedShadowed.image.image = uGroupPhoto
        }
    }
    
}
