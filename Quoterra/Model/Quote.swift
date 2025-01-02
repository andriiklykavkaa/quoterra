//
//  Quote+CoreDataProperties.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 27.12.2024.
//
//

import UIKit
import CoreData

@objc(Quote)
public class Quote: NSManagedObject {}

extension Quote {

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var author: String?
    @NSManaged public var date: Date?
    @NSManaged public var colorRaw: String?
    @NSManaged public var categories: Set<QuoteCategory>?
    
    public var color: QuoteColor? {
        get {
            guard let colorRaw = colorRaw else { return nil }
            return QuoteColor(rawValue: colorRaw)
        }
        set {
            colorRaw = newValue?.rawValue
        }
    }
}

extension Quote : Identifiable {}

extension Quote {
    func update() -> QuoteDTO {
        var dto = QuoteDTO()
        dto.id = self.id
        dto.text = self.text
        dto.author = self.author
        dto.date = self.date
        dto.colorRaw = self.colorRaw
        dto.categories = self.categories
        return QuoteDTO()
    }
}

struct QuoteDTO {
    var id: UUID?
    var text: String?
    var author: String?
    var date: Date?
    var colorRaw: String?
    var categories: Set<QuoteCategory>?    
}
