//
//  QuoteColor.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 26.12.2024.
//

import UIKit

public enum QuoteColor: String, CaseIterable, Codable {
    case defalut, red, blue, green, yellow, orange, purple
    
    func getUIColor() -> UIColor {
        switch self {
        case .defalut:
            UIColor.lightGray
        case .red:
            UIColor.systemRed
        case .blue:
            UIColor.systemBlue
        case .green:
            UIColor.systemGreen
        case .yellow:
            UIColor.systemYellow
        case .orange:
            UIColor.systemOrange
        case .purple:
            UIColor.systemPurple
        }
    }
}
