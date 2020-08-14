//
//  ViewController.swift
//  SwiftTicTacToe
//
//  Created by Patrick O'Leary on 8/10/20.
//  Copyright © 2020 Pat OLeary. All rights reserved.
//

import UIKit

final class TicTacToeViewController: UIViewController {
    
    @IBOutlet var ticTacToeView: UICollectionView!
    @IBOutlet var victoryLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    
    // Key: Square #, Value: Player #
    private var selectedSquares = [Int: Int]()
    private var isPlayerOneTurn = true
    private var player1Wins = 0
    private var player2Wins = 0
    private let winConditions = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ticTacToeView.delegate = self
        ticTacToeView.dataSource = self
    }
    @IBAction func didTapReset(_ sender: UIButton) {
        victoryLabel.text = "Tic-Tac-Toe"
        resetButton.isHidden = true
        selectedSquares.removeAll()
        isPlayerOneTurn = true
        ticTacToeView.visibleCells.compactMap{(cell) -> TicTacToeCell? in
            let cell = cell as? TicTacToeCell
            return cell
        }.forEach{$0.reset()}
        ticTacToeView.reloadData()
    }
}

extension TicTacToeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.frame.width
        let totalHeight = collectionView.frame.height
        let width = (totalWidth/3.9)
        let height = (totalHeight/3.9)
        return CGSize(width: width, height: height)
    }
}

extension TicTacToeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicTacToeCell", for: indexPath) as? TicTacToeCell {
            cell.squareNumber = indexPath.item
            cell.didSelect = didSelect(squareNumber:with:)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    private func didSelect(squareNumber: Int, with button: UIButton) {
        if self.isPlayerOneTurn {
            button.setTitle("X", for: .normal)
            //button.setBackgroundImage(UIImage(named: "X"), for: .normal)
            self.player(1, selected: squareNumber)
        } else {
            button.setTitle("O", for: .normal)
            //button.setBackgroundImage(UIImage(named: "O"), for: .normal)
            self.player(2, selected: squareNumber)
        }
        self.isPlayerOneTurn = !self.isPlayerOneTurn
    }
    
    private func player(_ playerNumber: Int, selected squareNumber: Int) {
        selectedSquares[squareNumber] = playerNumber
        if isVictoryFor(playerNumber: playerNumber) {
            showVictoryFor(playerNumber: playerNumber)
        } else if isDraw() {
            victoryLabel.text = "Tie game!"
            resetButton.isHidden = false
        }
    }
    
    private func isVictoryFor(playerNumber: Int) -> Bool {
        for condition in winConditions {
            var count = 0
            for square in condition {
                if selectedSquares[square] == playerNumber {
                    count += 1
                    if count == 3 {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    private func showVictoryFor(playerNumber: Int) {
        victoryLabel.text = "Player \(playerNumber) wins!"
        resetButton.isHidden = false
        if playerNumber == 1 {
            player1Wins += 1
        } else {
            player2Wins += 1
        }
    }
    
    private func isDraw() -> Bool {
        return selectedSquares.count == 9
    }
}



