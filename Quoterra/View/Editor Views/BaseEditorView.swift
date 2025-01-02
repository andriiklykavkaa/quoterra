//
//  EditorComponentView.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 29.12.2024.
//

import UIKit
import SnapKit

class BaseEditorView: UIView {
    
    let titleLabel = QULabel()
    let contentView = EditorContainerView()

    init(title: String) {
        super.init(frame: .zero)
        setupUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title: String) {
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.trailing.equalToSuperview().inset(6)
            $0.height.equalTo(32)
        }
        
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
