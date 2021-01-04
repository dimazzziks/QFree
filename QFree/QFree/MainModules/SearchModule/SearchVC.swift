//
//  SearchVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 27.10.2020.
//

import UIKit

protocol SearchViewProtocol: class {
    
}

class SearchVC: BaseViewController {
    var presenter: SearchPresenterProtocol?
    var searchText: String = ""
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsScopeBar = true
        setTitle()
        configureSearchBar()
    }
    
    func setTitle() {
        self.title = "Поиск"
    }
    
    func configureSearchBar() {
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
        
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searched text is \(self.searchText)")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBar begin editing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBar end editing")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}

extension SearchVC {
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
}

extension SearchVC: SearchViewProtocol {
    
}
