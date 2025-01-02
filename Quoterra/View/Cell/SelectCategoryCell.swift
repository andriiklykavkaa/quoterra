//
//  CategorySelectionCellTableViewCell.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 30.12.2024.
//

import UIKit
import SnapKit

final class SelectCategoryCell: UITableViewCell {
    
    static let reuseID = "SelectCategoryCell"
    
    private let titleLabel = QULabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }
    }
    
    func set(category: QuoteCategory) {
        titleLabel.text = category.title ?? "Unknown"
    }
}