//
//  CardInfoVC.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 12.08.23.
//

import UIKit
import FloatingPanel

class CardInfoVC: BaseVC {
    
    private lazy var navigation: MainNavigationBarView = {
        let nav = MainNavigationBarView()
        nav.bgColor = UIColor(hexString: "#F6F6F9")
        nav.title = "Card"
        return nav
    }()
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
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
    
    private lazy var floatingPC: FloatingPanelController = {
        let floatingPC = FloatingPanelController()
        floatingPC.delegate = self
        floatingPC.surfaceView.backgroundColor = .white
        floatingPC.surfaceView.cornerRadius = 24
        floatingPC.surfaceView.shadowHidden = true
        return floatingPC
    }()
    
    private lazy var cardInfoListVC: CardInfoFloatingVC = {
        let vc = CardInfoFloatingVC()
        return vc
    }()
    
    override func setupView() {
        super.setupView()
        hidesBottomBarWhenPushed = true
        view.backgroundColor = UIColor(hexString: "#F6F6F9")
        view.addSubview(navigation)
        view.addSubview(collection)
        
        floatingPC.set(contentViewController: cardInfoListVC)
        floatingPC.track(scrollView: cardInfoListVC.tableView)
        floatingPC.addPanel(toParent: self, animated: false)
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
                          padding: .init(top: 16, leading: 0, trailing: 0))
        collection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
    }
}

// MARK: UICollectionViewDelegate

extension CardInfoVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardInfoCell = collectionView.dequeue(for: indexPath)
        cell.setupData()
        cell.onClickedCopy = { [weak self] in
            guard let self = self else {return}
            self.showAlert(type: .success, body: "Pan kopyalandi")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - FloatingPanelController delegate

extension CardInfoVC: FloatingPanelControllerDelegate {
    
    func floatingPanelDidMove(_ vc: FloatingPanelController) {

    }
    
    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
        if vc.position == .tip {
        }
    }
//
    func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition) {
    }
}
