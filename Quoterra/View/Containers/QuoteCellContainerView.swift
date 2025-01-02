//
//  QuoteContainerView.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 26.12.2024.
//

import UIKit
import SnapKit

class QuoteCellContainerView: UIView {
    
    private let colorView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = .italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.minimumScaleFactor = 0.8
        label.font = .italicSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth =  true
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.minimumScaleFactor = 0.8
        label.font = .italicSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth =  true
        return label
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView()
        [authorLabel, categoryLabel]
            .forEach(stack.addArrangedSubview(_:))
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .secondarySystemBackground
        [colorView, textLabel, bottomStackView].forEach(addSubview(_:))
        
        colorView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(12)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.leading.equalTo(colorView.snp.trailing).offset(6)
            $0.trailing.bottom.equalToSuperview().inset(6)
            $0.height.equalTo(20)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(6)
            $0.leading.equalTo(colorView.snp.trailing).offset(6)
            $0.bottom.equalTo(bottomStackView.snp.top).offset(-10)
        }
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        
        layer.cornerRadius = 10
    }
    
    final func set(quote: Quote) {
        colorView.backgroundColor = quote.color?.getUIColor() ?? QuoteColor.defalut.getUIColor()
        textLabel.text = "\"\(quote.text ?? "...")\""
        authorLabel.text = "- \(quote.author ?? "unknown") -"
        categoryLabel.text = quote.categories?.first?.title ?? "..."
    }
}




#if DEBUG

import SwiftUI

struct QuoteContainerView_Previews: PreviewProvider {
    
    static func makeView() -> QuoteCellContainerView {
        let view = QuoteCellContainerView()
//        view.set(quote: Quote(text: "The kingdoms will fall and empires will break when the Destined arrive and spread the peace among men. The kingdoms will fall and empires will break when the Destined arrive and spread the peace among men. ", author: "Ludowig Beluci", categories: [QuoteCategory(title: "Prophecy")], color: .systemRed))
                       
        return view
    }
    
    static var previews: some View {
        Group {
            makeView()
                .asPreview()
                .frame(height: 120)
        }
    }
}

extension UIViewController {
    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        var viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            // No-op
        }
    }

    @available(iOS 13, *)
    func asPreview() -> some View {
        Preview(viewController: self)
    }
}

// MARK: - UIView Extensions

extension UIView {
    @available(iOS 13, *)
    private struct Preview: UIViewRepresentable {
        var view: UIView

        func makeUIView(context: Context) -> UIView {
            view
        }

        func updateUIView(_ view: UIView, context: Context) {
            // No-op
        }
    }

    @available(iOS 13, *)
    func asPreview() -> some View {
        Preview(view: self)
    }
}


#endif
