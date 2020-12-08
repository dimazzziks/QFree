//
//  SearchVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 27.10.2020.
//

import UIKit

class SearchVC: UIViewController {
    
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
        handleShowSearchBar()
    }
    
    func configureVC() {
        self.title = "Поиск"
        self.view.backgroundColor = .white
        
        searchBar.sizeToFit()
        searchBar.delegate = self
//        let app = UINavigationBarAppearance()
//        app.backgroundColor = Brandbook.defaultColor
//        app.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//
//        self.navigationController?.navigationBar.scrollEdgeAppearance = app
//        navigationController?.navigationBar.barTintColor = Brandbook.defaultColor
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        showSearchBarButton(shouldShow: true)
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }

}

extension SearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBar begin editing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBar end editing")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText is \(searchText)")
    }
}

extension SearchVC {
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
}
