//
//  SearchCell.swift
//  QFree
//
//  Created by Саид Дагалаев on 06.01.2021.
//

import UIKit

class SearchCell: UICollectionViewCell {
    static var reuseId: String = "SearchCell"
    
    let mainView = UIView()
    let name = UILabel()
    
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(mainView)
        mainView.addSubview(name)
        mainView.addSubview(tableView)
    }
    
    func setupViews() {
        setMainView()
        setNameLabel()
        setTableView()
    }
    
    func setMainView() {
        mainView.frame = bounds
        mainView.addShadow()
        mainView.backgroundColor = Brandbook.defaultColor
    }
    
    func setNameLabel() {
        name.frame = CGRect(x: 16, y: 0, width: frame.width, height: frame.height / 5)
        name.textColor = .white
        name.font = Brandbook.font()
    }
    
    func setTableView() {
        tableView.frame = CGRect(x: 0, y: 34, width: frame.width, height: frame.height)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    // TODO: Исправить
    func configure(with stringText: String) {
        name.text = stringText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
//        cell.nameLabel.text = "Еда"
        return cell
    }
}
