//
//  CountryVC.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import UIKit

class CountryVC: BaseVC {
    
    lazy var navigation: MainNavigationBarView = {
        let nav = MainNavigationBarView()
        nav.title = "Countries"
        return nav
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellClass: CountryTableCell.self)
        return tableView
    }()
    
    let viewModel = CountryVM()
    override func setupView() {
        super.setupView()
        view.addSubview(navigation)
        view.addSubview(tableView)
        setupViewModel()
        
    }
    override func setupLabels() {
        super.setupLabels()
    }
    override func setupAnchors() {
        super.setupAnchors()
        navigation.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 0, leading: 0, trailing: 0),
                          size: .init(width: 0, height: 84))
        tableView.anchor(top: navigation.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    fileprivate func setupViewModel() {
        startLoading()
        viewModel.getAllCountriesList()
        viewModel.successCallback = { [weak self] in
            self?.stopLoading()
            self?.tableView.reloadData()
        }
        viewModel.failureCallback = { [weak self] error in
            self?.showMessage(error.main.getMessage())
        }
    }
}

extension CountryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: CountryTableCell.self, forIndexPath: indexPath)
        cell.configureCell(item: viewModel.countryList[indexPath.row])
//        cell.configureCell()
        return cell
    }
}
