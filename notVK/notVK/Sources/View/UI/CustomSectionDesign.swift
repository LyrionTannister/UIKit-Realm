//
//  customSectionDesign.swift
//  notVK
//
//  Created by Roman on 16.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class CustomSectionDesign: UIView {
    
    let label = UILabel()
    let line = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
            
        setViews()
    }
    
    func setViews(){
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        line.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        line.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        line.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
