//
//  TicTacToeButton.swift
//  SwiftTicTacToe
//
//  Created by Patrick O'Leary on 8/17/20.
//  Copyright © 2020 Pat OLeary. All rights reserved.
//

import UIKit

final class TicTacToeButton: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var button: UIButton!
    
    var didSelect: (Int) -> UIImage? = {_ in return nil}
    var index: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TicTacToeButton", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    @IBAction func didTapButton(_ sender: UIButton) {
        guard let index = index else {
            assertionFailure("TicTacToeButton should have index assigned")
            return
        }
        selectedImageView.image = didSelect(index)
        button.isUserInteractionEnabled = false
    }
    
    func reset() {
        selectedImageView.image = nil
        button.isUserInteractionEnabled = true
    }
    
}
