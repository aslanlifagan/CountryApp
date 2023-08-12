//
//  NavigationBarView.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 23.12.22.
//

import UIKit
import Foundation
import SwiftUI

final class NavigationBarView: UIView {
    
    var title: String? {
        didSet {
            textLabel.text = title
        }
    }
        
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGreen
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    
    required init() {
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupUI() {
        addSubview(contentView)
        contentView.fillSuperview()
        contentView.addSubview(backButton)
        backButton.anchor(leading: contentView.leadingAnchor,
                              bottom: contentView.bottomAnchor,
                              padding: .init(leading: 12, bottom: -12), size: .init(width: 24, height: 24))
        contentView.addSubview(textLabel)
        textLabel.centerXToSuperview()
        textLabel.anchor(bottom: contentView.bottomAnchor, padding: .init(bottom: -12))
    }
    
    
    // MARK: - Action
    
    @objc func backButtonClicked() {
        let nav = UIApplication.getPresentedViewController() as! BaseNC
        nav.popViewController(animated: true)
    }
}


@available(iOS 13.0, *)
struct NavigationBarViewPreview: PreviewProvider {
    static var previews: some View {
        NavigationBarViewRepresentable()
        .previewLayout(.sizeThatFits)
    }
}

@available(iOS 13.0, *)
struct NavigationBarViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> NavigationBarView {
        return NavigationBarView()
    }
    
    func updateUIView(_ uiView: NavigationBarView, context: Context) {
        // Update the view if needed
    }
}
