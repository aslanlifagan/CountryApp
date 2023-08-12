//
//  CardInfoCell.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 12.08.23.
//

import UIKit
import SwiftUI

final class CardInfoCell: UICollectionViewCell {
    static let ID: String = "CardInfoCell"
    
    private lazy var contenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#F6F6F9")
        return view
    }()
    
    private lazy var cardImage: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "cardBg"))
//        img.alpha = 0.1
        img.roundRightCorner(16)
        return img
    }()
    
    private lazy var cardTypeImage: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "visa_icon"))
        return img
    }()
    
    private lazy var rightCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.roundLeftCorner(16)
        return view
    }()
    
    private lazy var cardDetailView: CardInfoDetailView = {
        let view = CardInfoDetailView()
        view.onClickedCopy = {[weak self] in
            guard let self = self else {return}
            self.onClickedCopy?()
        }
        return view
    }()
    
    var onClickedCopy: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        addSubview(contenView)
        contenView.fillSuperview()
        
        contenView.addSubview(cardImage)
        cardImage.anchor(top: contenView.topAnchor,
                         leading: contenView.leadingAnchor,
                         bottom: contenView.bottomAnchor,
                         padding: .init(top: 12, left: 0, bottom: -8, right: 0))
        cardImage.widthAnchor.constraint(equalTo: contenView.widthAnchor, multiplier: 0.3).isActive = true
        contenView.addSubview(cardTypeImage)
        cardTypeImage.anchor(bottom: cardImage.bottomAnchor,
                             trailing: cardImage.trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: -20, right: -20))
        
        contenView.addSubview(rightCardView)
        rightCardView.heightAnchor.constraint(equalTo: contenView.heightAnchor, multiplier: 0.6).isActive = true
        rightCardView.anchor(trailing: contenView.trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                             size: .init(width: 16, height: 0))
        rightCardView.centerYToSuperview()
        contenView.addSubview(cardDetailView)
        cardDetailView.heightAnchor.constraint(equalTo: contenView.heightAnchor, multiplier: 0.6).isActive = true
        cardDetailView.anchor(leading: cardImage.trailingAnchor,
                              trailing: rightCardView.leadingAnchor,
                              padding: .init(top: 0, left: 16, bottom: 0, right: -16))
        cardDetailView.centerYToSuperview()
        
    }
    
    public func setupData() {
        cardDetailView.setupData(cardname: "Kartmane AZN",
                                 amount: "890.00₼",
                                 pan: "0123  4567  8901  2345",
                                 dateTitle: "Tarix",
                                 date: "03/27",
                                 cvv: "CVV")
    }
}


@available(iOS 13.0, *)
struct CardInfoCellViewPreview: PreviewProvider {
    static var previews: some View {
        CardInfoCellRepresentable()
            .previewLayout(.sizeThatFits)
    }
}

@available(iOS 13.0, *)
struct CardInfoCellRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CardInfoCell {
        return CardInfoCell()
    }
    
    func updateUIView(_ uiView: CardInfoCell, context: Context) {
        // Update the view if needed
    }
}
