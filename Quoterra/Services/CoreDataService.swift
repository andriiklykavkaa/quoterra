//
//  QuoteService.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 27.12.2024.
//

import UIKit
import CoreData

final class CoreDataService: NSObject {
    static let shared = CoreDataService()
    private override init() {}
    
    private enum EntityNames: String {
        case quote = "Quote"
        case quoteCategory = "QuoteCategory"
    }
    
    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    //MARK: - Quote
    
    func createQuote(_ id: UUID, text: String, author: String, date: Date, colorRaw: String, categories: [QuoteCategory]) {
        guard let quoteEntityDescription = NSEntityDescription.entity(
            forEntityName: EntityNames.quote.rawValue,
            in: context) else { return}
        
        let quote = Quote(entity: quoteEntityDescription, insertInto: context)
        quote.id = id
        quote.text = text
        quote.author = author
        quote.date = date
        quote.colorRaw = colorRaw
        quote.categories = Set(categories)
        
        appDelegate.saveContext()
    }
    
    func fetchAllQuotes() -> [Quote] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.quote.rawValue)
        do {
            return (try? context.fetch(fetchRequest) as? [Quote]) ?? []
        }
    }
    
    func fetchQuote(with id: UUID) -> Quote? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.quote.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %id", id as CVarArg)
        do {
            return try context.fetch(fetchRequest).first as? Quote
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func updateQuote(with id: UUID, text: String, author: String, date: Date, colorRaw: String, categories: [QuoteCategory]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.quote.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %id", id as CVarArg)
        do {
            guard let quote = try context.fetch(fetchRequest).first as? Quote else { return }
            quote.text = text
            quote.author = author
            quote.date = date
            quote.colorRaw = colorRaw
            quote.categories = Set(categories)
            
            appDelegate.saveContext()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteQuote(with id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.quote.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %id", id as CVarArg)
        do {
            guard let quote = try context.fetch(fetchRequest).first as? Quote else { return }
            context.delete(quote)
            appDelegate.saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - QuoteCategory
    
    func createQuoteCategory(_ id: UUID, title: String, quotes: [Quote]) {
        guard let quoteCategoryEntityDescription = NSEntityDescription.entity(
            forEntityName: EntityNames.quoteCategory.rawValue,
            in: context) else { return }
        
        let quoteCategory = QuoteCategory(
            entity: quoteCategoryEntityDescription,
            insertInto: context)
        
        quoteCategory.id = id
        quoteCategory.title = title
        quoteCategory.quotes = Set(quotes)
        
        appDelegate.saveContext()
    }
    
    func fetchAllQouteCategories() -> [QuoteCategory] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.quoteCategory.rawValue)
        do {
            return (try? context.fetch(fetchRequest) as? [QuoteCategory]) ?? []
        }
    }
    
    func fetchQuoteCategory(with id: UUID) -> QuoteCategory? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.quoteCategory.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %id", id as CVarArg)
        do {
            return try context.fetch(fetchRequest).first as? QuoteCategory
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func updateQuoteCategory(with id: UUID, title: String, quotes: [Quote]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.quoteCategory.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %id", id as CVarArg)
        do {
            guard let quoteCategory = try context.fetch(fetchRequest).first as? QuoteCategory else { return }
            quoteCategory.id = id
            quoteCategory.title = title
            quoteCategory.quotes = Set(quotes)
            
            appDelegate.saveContext()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteQuoteCategory(with id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.quoteCategory.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %id", id as CVarArg)
        do {
            guard let quoteCategory = try context.fetch(fetchRequest).first as? QuoteCategory else { return }
            context.delete(quoteCategory)
            appDelegate.saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
}
