//
//  EditorInfoContainer.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 29.12.2024.
//

import UIKit

class EditorContainerView: UIView {

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .tertiarySystemBackground
        layer.cornerRadius = 15
        clipsToBounds = true
    }
}
