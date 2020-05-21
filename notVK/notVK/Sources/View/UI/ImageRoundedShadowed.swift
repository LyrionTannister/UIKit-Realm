//
//  ImageRoundedShadowed.swift
//  notVK
//
//  Created by Roman on 11.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class ImageRoundedShadowed: UIView {
    public var image: UIImageView!

    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImage()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addImage()
    }

    // MARK: - Image Creator
    func addImage() {
        image = UIImageView(frame: frame)
        addSubview(image)
    }

    override func layoutSubviews() {
        image.frame = bounds

        layer.backgroundColor = UIColor.clear.cgColor
    // MARK: - Shadow layer properties
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
    // MARK: - Image layer properties
        image.layer.cornerRadius = bounds.size.height / 2
        image.layer.masksToBounds = true
    }
}
