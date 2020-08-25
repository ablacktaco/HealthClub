//
//  ViewController.swift
//  HealthClub
//
//  Created by 陳姿穎 on 2020/8/20.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var memoryButton: UIButton!
    @IBOutlet weak var reactionButton: UIButton!
    @IBOutlet weak var dijkstraButton: UIButton!
    
    @IBAction func playGames(_ sender: UIButton) {
        switch sender {
        case memoryButton:
            let vc = MemoryViewController()
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoryButton.setRadius(radius: 60)
        reactionButton.setRadius(radius: 60)
        dijkstraButton.setRadius(radius: 60)
    }


}

