//
//  CategoryView.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 02.01.2025.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class CategoryView: UIView {

    private let titleLabel = QULabel()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        [titleLabel, deleteButton]
            .forEach(stackView.addArrangedSubview(_:))
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let deleteSubject: PassthroughSubject<Void, Never> = .init()
    var deletePublisher: AnyPublisher<Void, Never> {
        return deleteSubject.eraseToAnyPublisher()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        super.init(frame: .zero)
        setupUI()
        observeActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    private func observeActions() {
        deleteButton.tapPublisher
            .sink { [weak self] _ in
                self?.deleteSubject.send()
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
