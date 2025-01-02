//
//  QuoteListController.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 26.12.2024.
//

import UIKit
import Combine

class QuoteListController: UIViewController {
    
    private var categoryCollectionView: UICollectionView
    private let tableView = UITableView()
    
    private var quotes: [Quote] = [] {
        didSet { tableView.reloadData() }
    }
    private let viewModel: QuoteListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: QuoteListViewModel) {
        self.viewModel = viewModel
        let layout = CategoryCollectionViewFlowLayout()
        self.categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupBindings()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadQuotes()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func addButtonTapped() {
        let destViewModel = EditorViewModel()
        let destController = EditorController(viewModel: destViewModel)
        let navController = UINavigationController(rootViewController: destController)
        present(navController, animated: true)
    }
    
    private func setupBindings() {
        viewModel.$quotes
            .sink { quotes in
                self.quotes = quotes
            }
            .store(in: &cancellables)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(QuoteCell.self, forCellReuseIdentifier: QuoteCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
}

extension QuoteListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuoteCell.reuseID, for: indexPath)
                as? QuoteCell else { return UITableViewCell() }
        cell.set(quote: quotes[indexPath.row])
        return cell
    }
    
    
}
