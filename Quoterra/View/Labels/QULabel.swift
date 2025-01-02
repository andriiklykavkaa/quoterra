//
//  QULabel.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 29.12.2024.
//

import UIKit

class QULabel: UILabel {

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textColor = .secondaryLabel
        font = .systemFont(ofSize: 16, weight: .regular)
        textAlignment = .left
    }
}
