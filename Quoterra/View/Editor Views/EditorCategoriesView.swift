//
//  EditorCategoriesView.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 29.12.2024.
//

import UIKit
import SnapKit
import Combine

protocol EditorCategoriesViewDelegate: NSObject {
    func tappedAddButton()
    func removedCategory(_ category: QuoteCategory)
}

class EditorCategoriesView: BaseEditorView {
    
    private let addButton = AddCategoryButton()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    weak var delegate: EditorCategoriesViewDelegate?
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        super.init(title: "CATEGORIES")
        setupCategoriesUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCategoriesUI() {
        contentView.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.height.width.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    func set(_ categories: [QuoteCategory]) {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        categories.forEach { category in
            let categoryView = CategoryView()
            categoryView.set(title: category.title ?? "")
            categoryView.deletePublisher
                .sink { [weak self] _ in
                    self?.stackView.removeArrangedSubview(categoryView)
                    categoryView.removeFromSuperview()
                    self?.delegate?.removedCategory(category)
                    self?.updateAddButtonVisibility()
                }
                .store(in: &cancellables)
            
            stackView.addArrangedSubview(categoryView)
        }
        updateAddButtonVisibility()
    }
    
    @objc private func addButtonTapped() {
        delegate?.tappedAddButton()
    }
    
    private func updateAddButtonVisibility() {
        let isHidden = stackView.arrangedSubviews.count >= 3
        addButton.isHidden = isHidden
    }
}
