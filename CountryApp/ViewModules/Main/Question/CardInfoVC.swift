//
//  CardInfoVC.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 12.08.23.
//

import UIKit

class CardInfoVC: BaseVC {

    lazy var navigation: MainNavigationBarView = {
        let nav = MainNavigationBarView()
        nav.title = "Questions"
        return nav
    }()
    
    override func setupView() {
        super.setupView()
        view.addSubview(navigation)
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
    }
}
