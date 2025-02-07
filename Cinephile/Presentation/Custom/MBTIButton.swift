//
//  MBTIButton.swift
//  Cinephile
//
//  Created by 조우현 on 2/7/25.
//

import UIKit

class MBTIButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        
        self.isSelected = false
        setTitle(title, for: .normal)
        setTitleColor(.cineConditionGray, for: .normal)
        setTitleColor(.cinaWhite, for: .selected)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = .cineConditionBlue
                layer.borderColor = UIColor.clear.cgColor
                layer.borderWidth = 0
            } else {
                backgroundColor = .clear
                layer.borderColor = UIColor.cineConditionGray.cgColor
                layer.borderWidth = 1
            }
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
