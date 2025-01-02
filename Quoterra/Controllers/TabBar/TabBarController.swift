//
//  TabBarController.swift
//  Quoterra
//
//  Created by Andrii Klykavka on 26.12.2024.
//

import UIKit

class TabBarController: UITabBarController {
        
    private enum ControllerType {
        case quoteList
        case search
        case account
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarAppearance()
        viewControllers =  [
            createVC(type: .quoteList, title: "Quotes", systemImageName: "list.triangle"),
            createVC(type: .search, title: "Search", systemImageName: "magnifyingglass"),
            createVC(type: .account, title: "Account", systemImageName: "person.crop.circle")
        ]
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.secondaryLabel
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.label
        
        tabBar.standardAppearance = appearance
    }
    
    private func createVC(type: ControllerType, title: String, systemImageName: String) -> UINavigationController {
        var controller: UIViewController
        switch type {
        case .quoteList:
            let viewModel = QuoteListViewModel()
            controller = QuoteListController(viewModel: viewModel)
        case .search:
            controller = SearchController()
        case .account:
            controller = AccountController()
        }
        
        controller.title = title
        controller.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: systemImageName), tag: viewControllers?.count ?? 0)
        
        return UINavigationController(rootViewController: controller)
    }
    
}
