//
//  TicTacToeCell.swift
//  SwiftTicTacToe
//
//  Created by Patrick O'Leary on 8/10/20.
//  Copyright © 2020 Pat OLeary. All rights reserved.
//

import UIKit

final class TicTacToeCell: UICollectionViewCell {
    
    var squareNumber: Int?
    var didSelect: (Int, UIButton) -> Void = {_,_ in}
    
    @IBOutlet var button: UIButton!
    
    @IBAction func didTapCellButton(_ sender: UIButton) {
        guard let squareNumber = self.squareNumber else {
            assertionFailure("TicTacToeCell should have item number assigned at collectionView dequeue")
            return
        }
        didSelect(squareNumber, button)
        self.button.isUserInteractionEnabled = false
    }
    
    func reset() {
        squareNumber = 0
        didSelect = {_,_ in}
        self.button.setTitle("-", for: .normal)
        self.button.isUserInteractionEnabled = true
    }
    
}

