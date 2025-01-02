//
//  QuoteInfoView.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 29.12.2024.
//

import UIKit
import SnapKit

class EditorInfoView: BaseEditorView {
    
    private let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    private let quoteTextView: UITextView = {
        let textView = UITextView()
        textView.font = .italicSystemFont(ofSize: 16)
        textView.textColor = .label
        textView.borderStyle = .none
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        return textView
    }()
    private let separatorView = SeparatorView()
    private let authorTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Author..."
        field.font = .italicSystemFont(ofSize: 16)
        field.textColor = .secondaryLabel
        field.borderStyle = .none
        field.backgroundColor = .clear
        return field
    }()
    
    private var quoteTextViewHeightConstraint: Constraint?

    init() {
        super.init(title: "INFO")
        setupInfoUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInfoUI() {
        quoteTextView.delegate = self

        
        contentView.addSubview(colorView)
        contentView.addSubview(quoteTextView)
        contentView.addSubview(separatorView)
        contentView.addSubview(authorTextField)
        
        colorView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(12)
        }
        
        authorTextField.snp.makeConstraints {
            $0.leading.equalTo(colorView.snp.trailing).offset(6)
            $0.bottom.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalTo(authorTextField)
            $0.bottom.equalTo(authorTextField.snp.top).inset(-2)
            $0.height.equalTo(0.5)
        }
        
        quoteTextView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalTo(authorTextField)
            self.quoteTextViewHeightConstraint = $0.height.equalTo(30).constraint
            $0.bottom.equalTo(separatorView.snp.top).inset(-20)
        }
    }
}

extension EditorInfoView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let fittingSize = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        let newHeight = max(30, fittingSize.height)
        
        if quoteTextViewHeightConstraint?.layoutConstraints.first?.constant != newHeight {
            quoteTextViewHeightConstraint?.update(offset: newHeight)
            self.superview?.layoutIfNeeded()
        }
    }
}

#if DEBUG

import SwiftUI

struct QuoteInfoView_Previews: PreviewProvider {
    
    static func makeView() -> EditorInfoView {
        let view = EditorInfoView()
                       
        return view
    }
    
    static var previews: some View {
        Group {
            makeView()
                .asPreview()
                .frame(height: 160)
                .background(Color(UIColor.secondarySystemBackground))
        }
    }
}

#endif
