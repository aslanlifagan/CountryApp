//
//  MainNavigationBarView.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import UIKit
import Foundation
import SwiftUI

final class MainNavigationBarView: UIView {
    
    var title: String? {
        didSet {
            textLabel.text = title
        }
    }
    
    var bgColor: UIColor? = .mainGreen {
        didSet {
            contentView.backgroundColor = bgColor
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
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
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
        contentView.addSubview(textLabel)
        textLabel.centerXToSuperview()
        textLabel.anchor(bottom: contentView.bottomAnchor, padding: .init(bottom: -4))
    }
    
    
    // MARK: - Action
    
    @objc func backButtonClicked() {
        let nav = UIApplication.getPresentedViewController() as! BaseNC
        nav.popViewController(animated: true)
    }
}

@available(iOS 13.0, *)
struct MainNavigationBarViewPreview: PreviewProvider {
    static var previews: some View {
        MainNavigationBarViewRepresentable()
            .previewLayout(.sizeThatFits)
    }
}

@available(iOS 13.0, *)
struct MainNavigationBarViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> MainNavigationBarView {
        return MainNavigationBarView()
    }
    
    func updateUIView(_ uiView: MainNavigationBarView, context: Context) {
        // Update the view if needed
    }
}
