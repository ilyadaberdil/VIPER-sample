//
//  InfoBadgeView.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import UIKit
import SnapKit

final class InfoBadgeView: UIView {

    private let infoLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setup
private extension InfoBadgeView {
    func setupUI() {
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(2)
            make.leading.trailing.equalToSuperview().inset(6)
        }
    }
}

// MARK: - Prepare
extension InfoBadgeView {
    func prepare(_ model: InfoBadgeViewModel) {
        infoLabel.font = model.style.font
        infoLabel.text = model.info
        infoLabel.textColor = model.style.textColor
        backgroundColor = model.style.backgroundColor
        layer.cornerRadius = model.style.cornerRadius
    }
}
