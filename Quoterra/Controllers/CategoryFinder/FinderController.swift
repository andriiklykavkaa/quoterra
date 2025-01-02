//
//  CategoryFinderController.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 29.12.2024.
//

import UIKit
import SnapKit
import Combine

protocol FinderControllerDelegate: NSObject {
    func didSelectCategory(_ category: QuoteCategory)
}

class FinderController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .secondarySystemBackground
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    private let titleLabel = QULabel()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SelectCategoryCell.self, forCellReuseIdentifier: SelectCategoryCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = true
        tableView.rowHeight = 60
        return tableView
    }()
    
    private let viewModel: FinderViewModel
    weak var delegate: FinderControllerDelegate?
    private var cancellables: Set<AnyCancellable> = []
    
    private let bannedCategories: [QuoteCategory]
    private var categories: [QuoteCategory] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(viewModel: FinderViewModel, bannedCategories: [QuoteCategory]) {
        self.viewModel = viewModel
        self.bannedCategories = bannedCategories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupGestures()
        setupUI()
        viewModel.fetchQuoteCategories(without: bannedCategories)
    }
    
    private func setupBindings() {
        viewModel.$categories
            .sink { categories in
                self.categories = categories
            }
            .store(in: &cancellables)
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(screenTapped(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func screenTapped(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: view)
        if !containerView.frame.contains(tapLocation) {
            dismiss(animated: true)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.height.equalTo(320)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview().offset(-76)
        }
        
        titleLabel.text = "SELECT CATEGORY"
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension FinderController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectCategoryCell.reuseID, for: indexPath)
                as? SelectCategoryCell else {
            return UITableViewCell()
        }
        cell.set(category: categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        print("Category selected.")
        delegate?.didSelectCategory(category)
        dismiss(animated: true)
    }
}
