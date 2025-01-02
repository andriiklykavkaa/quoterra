//
//  QuoteListViewModel.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 26.12.2024.
//

import UIKit
import Combine

final class QuoteListViewModel {
    
    @Published private(set) var quotes: [Quote] = []
    private let service: CoreDataService
    
    init(service: CoreDataService = .shared) {
        self.service = service
    }
    
    func loadQuotes() {
        self.quotes = service.fetchAllQuotes()
    }
}
