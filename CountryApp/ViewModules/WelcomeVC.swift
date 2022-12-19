//
//  WelcomeVC.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 19.12.22.
//

import UIKit

class WelcomeVC: BaseVC {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var leftSideView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainOrange
        view.roundBottomRightCorner(radius: 120)
        return view
    }()
    
    lazy var rightSideView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGreen
        view.roundBottomLeftCorner(radius: 120)
        return view
    }()
    
    lazy var testLabel: UILabel = {
       let label = UILabel()
        label.text = "Welcome\nmy World"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .systemGray4
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(leftSideView)
        contentView.addSubview(rightSideView)
        leftSideView.addSubview(testLabel)

    }
    override func setupLabels() {
        super.setupLabels()
    }
    override func setupAnchors() {
        super.setupAnchors()
        scrollView.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor)
        contentView.fillSuperview()
        contentView.anchorWidth(to: self.view)
        leftSideView.anchorSuperview(top: true,
                                     leading: true,
                                     padding: .init(top: -48, leading: 0),
                                     size: .init(
                                        width: UIScreen.main.bounds.width*0.6,
                                        height: UIScreen.main.bounds.height*0.4))
        rightSideView.anchorSuperview(top: true,
                                     trailing: true,
                                     padding: .init(top: -48, trailing: 0),
                                     size: .init(
                                        width: UIScreen.main.bounds.width*0.6,
                                        height: UIScreen.main.bounds.height*0.35))
        
        testLabel.centerYToSuperview()
        testLabel.anchor(leading: leftSideView.leadingAnchor, padding: .init(leading: 8))
    }
}
