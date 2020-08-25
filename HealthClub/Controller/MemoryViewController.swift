//
//  MemoryViewController.swift
//  HealthClub
//
//  Created by 陳姿穎 on 2020/8/20.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {
    
    @IBOutlet weak var memoryCollectionView: UICollectionView!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var cardName: [String] = ["jerry", "yucheng", "jes", "lacie", "joey", "yahan", "jerry", "yucheng", "jes", "lacie", "joey", "yahan"]
    var cardState: [Bool] = []
    var completePair: Int = 0
    var selectIndex: Int?
    var canSelect: Bool = false
    var timer: Timer?
    
    @IBAction func startGame(_ sender: UIButton) {
        sender.isEnabled = false
        resetTheCard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardState = Array(repeating: false, count: cardName.count)
        setCollectionView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    fileprivate func setCollectionView() {
        memoryCollectionView.dataSource = self
        memoryCollectionView.delegate = self
        memoryCollectionView.register(cellType: MemoryCardCollectionViewCell.self)
    }
    
    fileprivate func resetTheCard() {
        completePair = 0
        cardName.shuffle()
        cardState = Array(repeating: true, count: cardName.count)
        memoryCollectionView.reloadData()
        var initialTime = 5
        countdownLabel.text = "\(initialTime)s"
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            initialTime -= 1
            self.countdownLabel.text = "\(initialTime)s"
            if initialTime == 0 {
                timer.invalidate()
                self.canSelect = true
                self.cardState = Array(repeating: false, count: self.cardName.count)
                self.memoryCollectionView.reloadData()
            }
        })
    }

}

extension MemoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MemoryCardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setImage(name: cardName[indexPath.row], isOn: cardState[indexPath.row])
        return cell
    }
    
}

extension MemoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !cardState[indexPath.row], canSelect {
            cardState[indexPath.row] = true
            if let index = selectIndex {
                if cardName[index] == cardName[indexPath.row] {
                    completePair += 1
                    if completePair == cardName.count / 2 {
                        startButton.isEnabled = true
                    }
                } else {
                    canSelect = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.canSelect = true
                        self.cardState[indexPath.row] = false
                        self.cardState[index] = false
                        collectionView.reloadItems(at: [indexPath, IndexPath(item: index, section: 0)])
                    }
                }
                selectIndex = nil
            } else {
                selectIndex = indexPath.row
            }
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
}


extension MemoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cardWidth = (collectionView.frame.width - 60) / 4
        return CGSize(width: cardWidth, height: cardWidth * 4 / 3)
    }
    
}
