//
//  AddQouteController.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 27.12.2024.
//

import UIKit
import SnapKit

class EditorController: UIViewController {
    
    private let infoView = EditorInfoView()
    private let colorView = EditorColorView()
    private let categoriesView = EditorCategoriesView()
    
    private lazy var stackView : UIStackView = {
        let stack = UIStackView()
        [infoView, colorView, categoriesView]
            .forEach(stack.addArrangedSubview(_:))
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private let viewModel: EditorViewModel
    private var quoteDTO: QuoteDTO
    
    init(viewModel: EditorViewModel, quoteDTO: QuoteDTO = QuoteDTO()) {
        self.viewModel = viewModel
        self.quoteDTO = quoteDTO
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupGestures()
        setupBindings()
        setupUI()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Add Quote"
        view.backgroundColor = .secondarySystemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        // save quote logic handle here
        self.dismiss(animated: true)
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func screenTapped() {
        view.endEditing(true)
    }
    
    private func setupBindings() {
        
    }
    
    private func setupUI() {
        categoriesView.delegate = self
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension EditorController: EditorCategoriesViewDelegate {
    func tappedAddButton() {
        view.endEditing(true)
        let destController = FinderController(
            viewModel: FinderViewModel(),
            bannedCategories: Array(quoteDTO.categories ?? [])
        )
        destController.modalPresentationStyle = .overFullScreen
        destController.modalTransitionStyle = .crossDissolve
        destController.delegate = self
        present(destController, animated: true)
    }
}

extension EditorController: FinderControllerDelegate {
    func didSelectCategory(_ category: QuoteCategory) {
        quoteDTO.categories?.insert(category)
        categoriesView.updateCategories(Array(quoteDTO.categories ?? []))
        
    }
}
