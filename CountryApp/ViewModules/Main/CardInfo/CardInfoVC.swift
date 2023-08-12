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
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(cell: CardInfoCell.self)
        return collectionView
    }()
    
    override func setupView() {
        super.setupView()
        view.addSubview(navigation)
        view.addSubview(collection)
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
        collection.anchor(top: navigation.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 16, leading: 0, trailing: 0),
                          size: .init(width: 0, height: 200))
    }
}

// MARK: UICollectionViewDelegate

extension CardInfoVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardInfoCell = collectionView.dequeue(for: indexPath)
        cell.setupData(title: "title", desc: "Desc")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
