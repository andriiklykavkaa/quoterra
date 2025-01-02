//
//  EditorCategoriesView.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 29.12.2024.
//

import UIKit
import SnapKit

protocol EditorCategoriesViewDelegate: NSObject {
    func tappedAddButton()
}

class EditorCategoriesView: BaseEditorView {
    
    private let addButton = AddCategoryButton()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SelectCategoryCell.self, forCellReuseIdentifier: SelectCategoryCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.rowHeight = 60
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .systemRed
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        [addButton, tableView]
            .forEach(stack.addArrangedSubview(_:))
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    weak var delegate: EditorCategoriesViewDelegate?
    private var categories: [QuoteCategory] = [] {
        didSet {
            reloadTableView()
        }
    }
    
    init() {
        super.init(title: "CATEGORIES")
        setupCategoriesUI()
        reloadTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCategories(_ categories: [QuoteCategory]) {
        self.categories = categories
    }
    
    private func setupCategoriesUI() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(0)
        }
    }
    
    private func reloadTableView() {
        tableView.reloadData()
        tableView.snp.updateConstraints {
            $0.height.equalTo(categories.count * 60)
        }
        stackView.layoutIfNeeded()
    }
    
    @objc private func addButtonTapped() {
        delegate?.tappedAddButton()
    }
}

extension EditorCategoriesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectCategoryCell.reuseID, for: indexPath)
                as? SelectCategoryCell else { return UITableViewCell() }
        cell.set(category: categories[indexPath.row])
        return cell
    }
}
