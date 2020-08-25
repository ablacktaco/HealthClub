//
//  MemoryCardCollectionViewCell.swift
//  HealthClub
//
//  Created by 陳姿穎 on 2020/8/22.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit
import Reusable

class MemoryCardCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var cardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setRadius(radius: 5)
    }
    
    func setImage(name: String, isOn: Bool) {
        if isOn {
            cardImageView.image = UIImage(named: name)
        } else {
            cardImageView.image = UIImage(named: "polly")
        }
    }

}
