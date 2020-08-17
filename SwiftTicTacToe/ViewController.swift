//
//  ViewController.swift
//  SwiftTicTacToe
//
//  Created by Patrick O'Leary on 8/10/20.
//  Copyright © 2020 Pat OLeary. All rights reserved.
//

import UIKit

final class TicTacToeViewController: UIViewController {
    
    @IBOutlet var victoryLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var button0: TicTacToeButton!
    @IBOutlet var button1: TicTacToeButton!
    @IBOutlet var button2: TicTacToeButton!
    @IBOutlet var button3: TicTacToeButton!
    @IBOutlet var button4: TicTacToeButton!
    @IBOutlet var button5: TicTacToeButton!
    @IBOutlet var button6: TicTacToeButton!
    @IBOutlet var button7: TicTacToeButton!
    @IBOutlet var button8: TicTacToeButton!
    @IBOutlet var player1WinsLabel: UILabel!
    @IBOutlet var player2WinsLabel: UILabel!
    
    private var allButtons: [TicTacToeButton] {
        return [button0, button1, button2,
                button3, button4, button5,
                button6, button7, button8]
    }
    
    /// Key: Square #, Value: Player #
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
        assignAllButtons()
    }
    
    @IBAction func didTapReset(_ sender: UIButton) {
        victoryLabel.text = "Tic-Tac-Toe"
        resetButton.isHidden = true
        selectedSquares.removeAll()
        isPlayerOneTurn = true
        allButtons.forEach{$0.reset()}
    }
    
    private func assignAllButtons() {
        var index = 0
        for button in allButtons {
            button.index = index
            button.didSelect = didSelect(squareNumber:)
            index += 1
        }
    }
}

extension TicTacToeViewController {
    
    private func didSelect(squareNumber: Int) -> UIImage? {
        if self.isPlayerOneTurn {
            self.player(1, selected: squareNumber)
            self.isPlayerOneTurn = !self.isPlayerOneTurn
            return UIImage(named: "X")
        } else {
            self.player(2, selected: squareNumber)
            self.isPlayerOneTurn = !self.isPlayerOneTurn
            return UIImage(named: "O")
        }
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
                } else {
                    break
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
            player1WinsLabel.text = "\(player1Wins)"
        } else {
            player2Wins += 1
            player2WinsLabel.text = "\(player2Wins)"
        }
    }
    
    private func isDraw() -> Bool {
        return selectedSquares.count == 9
    }
}



