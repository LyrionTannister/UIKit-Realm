//
//  Dots.swift
//  notVK
//
//  Created by Roman on 16.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

@IBDesignable

class Dots: UIImageView {
    override class var layerClass: AnyClass {
          return CAShapeLayer.self
      }
      var dotLayer: CAShapeLayer {
          return self.layer as! CAShapeLayer
      }

    
    @IBInspectable var color: UIColor = .lightGray {
           didSet { self.updateColors() }
       }
    @IBInspectable var borderWidth: CGFloat = 3 {
        didSet { self.updateWidth() }
    }
    @IBInspectable var radius: CGFloat = 5 {
        didSet { self.udateRadius() }
    }
    
    
    
    func updateColors() {
        self.dotLayer.borderColor = self.color.cgColor
    }
    func updateWidth() {
        self.dotLayer.borderWidth = self.borderWidth
    }
    func udateRadius() {
        self.dotLayer.cornerRadius = self.radius
    }
}
