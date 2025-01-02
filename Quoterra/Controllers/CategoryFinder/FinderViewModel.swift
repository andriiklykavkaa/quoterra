//
//  CategoryFinderViewModel.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 30.12.2024.
//

import UIKit
import SnapKit
import Combine

final class FinderViewModel {
    
    @Published
    private(set) var categories: [QuoteCategory] = []
    private let service: CoreDataService
    
    init(service: CoreDataService = .shared) {
        self.service = service
    }
    
    func fetchQuoteCategories(without bannedCategories: [QuoteCategory]) {
        let bannedIds = Set(bannedCategories.map { $0.id })
        let fetchedCategories = service.fetchAllQouteCategories()
        categories = fetchedCategories.filter { !bannedIds.contains($0.id) }
    }
}
