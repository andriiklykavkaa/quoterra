//
//  QuoteCategory+CoreDataProperties.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 27.12.2024.
//
//

import Foundation
import CoreData

@objc(QuoteCategory)
public class QuoteCategory: NSManagedObject {}

extension QuoteCategory {

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var quotes: Set<Quote>?

}

extension QuoteCategory : Identifiable {}
