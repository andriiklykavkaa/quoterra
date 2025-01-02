//
//  AddQuoteViewModel.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 27.12.2024.
//

import Foundation
import Combine

final class EditorViewModel {
    
    private let service: CoreDataService
    
    init(service: CoreDataService = .shared) {
        self.service = service
    }
    
    func createMockQuotesAndCategories() {
        service.createQuote(UUID(), text: "Frankly my dear I don't give  adamn", author: "Frank Sinatra", date: Date(), colorRaw: QuoteColor.blue.rawValue, categories: [])
        service.createQuote(UUID(), text: "And in case I don't see you, good afternoon, good evening and good night!", author: "Truman Babek", date: Date(), colorRaw: QuoteColor.red.rawValue, categories: [])
        service.createQuote(UUID(), text: "I'll be back", author: "Terminator", date: Date(), colorRaw: QuoteColor.defalut.rawValue, categories: [])
        
        service.createQuoteCategory(UUID(), title: "Motivation", quotes: [])
        service.createQuoteCategory(UUID(), title: "Happiness", quotes: [])
        service.createQuoteCategory(UUID(), title: "History", quotes: [])
    }
}
