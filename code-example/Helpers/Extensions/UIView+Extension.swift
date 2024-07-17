//
//  UIView+Extension.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import Foundation
import UIKit

extension UIView {
    
    func shadow(opacity: Float = 0.5,
                color: CGColor = UIColor.black.cgColor,
                shadowOffset: CGSize = .zero) {
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color
        self.layer.shadowOffset = shadowOffset
    }
    
    func radius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}
