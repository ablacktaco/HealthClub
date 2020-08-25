//
//  UIViewExtension.swift
//  HealthClub
//
//  Created by 陳姿穎 on 2020/8/22.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

extension UIView {
    
    func setRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
}
