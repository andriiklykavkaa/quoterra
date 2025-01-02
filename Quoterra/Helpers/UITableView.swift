//
//  UITableView.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 31.12.2024.
//

import UIKit

extension UITableView {
    override open var intrinsicContentSize: CGSize {
        
        self.layoutIfNeeded()
        return CGSize(width: self.contentSize.width, height: self.contentSize.height)
    }
}
