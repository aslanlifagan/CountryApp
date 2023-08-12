//
//  CardInfoListCell.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 12.08.23.
//

import UIKit
import SwiftUI

final class CardInfoListCell: UITableViewCell {
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Title"
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Desc"
        return label
    }()

    private lazy var imageHolder: UIView = {
        let holder = UIView()
        holder.backgroundColor = UIColor(hexString: "#F6F6F9")
        holder.layer.cornerRadius = 12
        holder.anchorSize(.init(width: 44, height: 44))
        return holder
    }()
    
    lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = UIImage(systemName: "circle.fill" )
        image.anchorSize(.init(width: 20, height: 20))
        return image
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descLabel])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageHolder, labelStackView])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.separatorInset = .init(top: 0, left: 64, bottom: 0, right: 24)
        addSubview(stackView)
        imageHolder.addSubview(iconView)
        iconView.centerInSuperview()
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 4, leading: 8, bottom: -4, trailing: -8))

    }
    
    func configureCell() {
        nameLabel.text = "Kart məlumatları"
        descLabel.text = "Hesab, Kredit, Kartın ATM-də qalması,.."
    }
}

@available(iOS 13.0, *)
struct CardInfoListCellViewPreview: PreviewProvider {
    static var previews: some View {
        CardInfoListCellRepresentable()
        .previewLayout(.sizeThatFits)
    }
}

@available(iOS 13.0, *)
struct CardInfoListCellRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CardInfoListCell {
        return CardInfoListCell()
    }
    
    func updateUIView(_ uiView: CardInfoListCell, context: Context) {
        // Update the view if needed
    }
}
