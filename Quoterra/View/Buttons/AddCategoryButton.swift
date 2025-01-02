//
//  AddCategoryButton.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 29.12.2024.
//

import UIKit

class AddCategoryButton: UIButton {

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.frame.size = CGSize(width: 50, height: 50)
        
        layer.cornerRadius = 25
        clipsToBounds = true
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.secondaryLabel.cgColor
        
        backgroundColor = UIColor.secondarySystemBackground
        
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        setImage(image, for: .normal)
        tintColor = .secondaryLabel
    }
}

#if DEBUG

import SwiftUI

struct AddCategoryButton_Previews: PreviewProvider {
    
    static func makeView() -> AddCategoryButton {
        let view = AddCategoryButton()
                       
        return view
    }
    
    static var previews: some View {
        Group {
            makeView()
                .asPreview()
                .frame(width: 50, height: 50)
                .background(Color(UIColor.secondarySystemBackground))
        }
    }
}

#endif
