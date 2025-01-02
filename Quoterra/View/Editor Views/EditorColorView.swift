//
//  EditorColorView.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 29.12.2024.
//

import UIKit
import SnapKit

class EditorColorView: BaseEditorView {
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()

    init() {
        super.init(title: "COLOR")
        setupStackView()
        setupColorUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        QuoteColor.allCases.forEach {
            let view = UIView()
            view.backgroundColor = $0.getUIColor()
            view.layer.cornerRadius = 15
            view.clipsToBounds = true
            stackView.addArrangedSubview(view)
            
            view.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 30, height: 30))
            }
        }
    }
    
    private func setupColorUI() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.top.bottom.equalToSuperview().inset(12)
        }
    }
}

#if DEBUG

import SwiftUI

struct EditorColorView_Previews: PreviewProvider {
    
    static func makeView() -> EditorColorView {
        let view = EditorColorView()
                       
        return view
    }
    
    static var previews: some View {
        Group {
            makeView()
                .asPreview()
                .frame(height: 100)
                .background(Color(UIColor.secondarySystemBackground))
        }
    }
}

#endif
