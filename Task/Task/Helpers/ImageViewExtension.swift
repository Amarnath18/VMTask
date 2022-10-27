//
//  ImageViewExtension.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import UIKit

extension UIImageView {
    
    func makeRounded() {
        
        layer.borderWidth = 0.3
        layer.masksToBounds = false
        layer.borderColor = UIColor.red.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
