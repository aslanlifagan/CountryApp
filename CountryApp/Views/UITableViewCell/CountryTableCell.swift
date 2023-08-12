//
//  CountryTableCell.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import UIKit
import SwiftUI

final class CountryTableCell: UITableViewCell {
    
    
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

    lazy var flagView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.image = UIImage(systemName: "circle.fill" )
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
        let stackView = UIStackView(arrangedSubviews: [flagView, labelStackView])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    override func prepareForReuse() {
        flagView.image = nil
    }
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
        flagView.anchorSize(.init(width: 40, height: 40))
        addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 4, leading: 8, bottom: -4, trailing: -8))
    }
    
    func configureCell(item: CountryElement) {
        nameLabel.text = item.name?.common
        descLabel.text = item.name?.official
        flagView.loadURL(item.flags?.png ?? "")
    }
}

@available(iOS 13.0, *)
struct CountryTableCellViewPreview: PreviewProvider {
    static var previews: some View {
      CountryTableCellRepresentable()
        .previewLayout(.sizeThatFits)
    }
}

@available(iOS 13.0, *)
struct CountryTableCellRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CountryTableCell {
        return CountryTableCell()
    }
    
    func updateUIView(_ uiView: CountryTableCell, context: Context) {
        // Update the view if needed
    }
}
