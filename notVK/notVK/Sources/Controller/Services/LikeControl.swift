//
//  LikeControl.swift
//  notVK
//
//  Created by Roman on 22.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    
    
    var imageView = UIImageView()
    var likeCountLabel = UILabel()
    
    var likeCounter = 0
    var isLike: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds
    }
    
    func setLike(count: Int){
        likeCounter = count
        setLikeCounterLabel()
    }
    
    func setView() {
        
        self.addSubview(imageView)
        self.addTarget(self, action: #selector(tapControl), for: .touchUpInside)
        
        imageView.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        imageView.image = UIImage(systemName: "heart")
        
        setLikeCounterLabel()
    }
    
    func setLikeCounterLabel(){
        addSubview(likeCountLabel)
        UIView.transition(with: likeCountLabel,
                          duration: 0.3,
                          options: .transitionFlipFromTop,
                          animations: {
                        self.likeCountLabel.text = String(self.likeCounter)
        })
        
             
             likeCountLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
             likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
             likeCountLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true
             likeCountLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
    
    @objc func tapControl(){
        isLike.toggle()
        if isLike {
            imageView.image = UIImage(systemName: "heart.fill")
            likeCounter += 1
            setLikeCounterLabel()
        } else {
            imageView.image = UIImage(systemName: "heart")
            likeCounter -= 1
            setLikeCounterLabel()
        }
    }
    
}
