//
//  CardInfoFloatingVC.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 12.08.23.
//

import UIKit

class CardInfoFloatingVC: BaseVC {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellClass: CardInfoListCell.self)
        return tableView
    }()
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    override func setupLabels() {
        super.setupLabels()
    }
    override func setupAnchors() {
        super.setupAnchors()
        
        
        view.addSubview(tableView)
        tableView.fillSuperview(padding: .init(top: 40, left: 0, bottom: 0, right: 0))
    }
}

extension CardInfoFloatingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: CardInfoListCell.self, forIndexPath: indexPath)
        cell.configureCell()
        return cell
    }
}
