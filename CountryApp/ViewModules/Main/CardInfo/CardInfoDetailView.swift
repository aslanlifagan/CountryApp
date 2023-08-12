//
//  CardInfoDetailView.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 12.08.23.
//

import UIKit
import Foundation
import SwiftUI

final class CardInfoDetailView: UIView {
    
    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#A1A7BC")
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var cardStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardNameLabel, amountLabel])
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var panLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "copy_icon"), for: .normal)
        button.addTarget(self, action: #selector(copyButtonClicked), for: .touchUpInside)
        button.anchorSize(.init(width: 16, height: 16))
        return button
    }()
    
    private lazy var panStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [panLabel, copyButton])
        stackView.spacing = 12
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var dateTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#A1A7BC")
        label.font = .systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateTitleLabel, dateLabel])
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var cvvView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.roundAllCorners(16)
        return view
    }()
    
    lazy var cvvLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private lazy var cvvStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateStackView, cvvView])
        stackView.spacing = 12
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardStackView, panStackView, cvvStackView])
        stackView.spacing = 18
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    var onClickedCopy: (() -> Void)?
    
    required init() {
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupUI() {
        addSubview(verticalStackView)
        verticalStackView.fillSuperview()
        cvvView.anchorSize(.init(width: 58, height: 32))
        cvvView.addSubview(cvvLabel)
        cvvLabel.centerInSuperview()
    }
    
    func setupData(
        cardname: String,
        amount: String,
        pan: String,
        dateTitle: String,
        date: String,
        cvv: String) {
            cardNameLabel.text = cardname
            amountLabel.text = amount
            panLabel.text = pan
            dateTitleLabel.text = dateTitle
            dateLabel.text = date
            cvvLabel.text = cvv
    }
    
    
    // MARK: - Action
    
    @objc func copyButtonClicked() {
        onClickedCopy?()
    }
}


@available(iOS 13.0, *)
struct CardInfoDetailViewPreview: PreviewProvider {
    static var previews: some View {
        CardInfoDetailViewRepresentable()
        .previewLayout(.sizeThatFits)
    }
}

@available(iOS 13.0, *)
struct CardInfoDetailViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CardInfoDetailView {
        return CardInfoDetailView()
    }
    
    func updateUIView(_ uiView: CardInfoDetailView, context: Context) {
        // Update the view if needed
    }
}
