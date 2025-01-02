//
//  QuoteCell.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 26.12.2024.
//

import UIKit
import SnapKit

class QuoteCell: UITableViewCell {
    
    static let reuseID = "QuoteCell"
    private let containerView = QuoteCellContainerView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
    }
    
    final func set(quote: Quote) {
        containerView.set(quote: quote)
    }
}


