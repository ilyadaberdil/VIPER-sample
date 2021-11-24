//
//  InfoHeaderView.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 22.11.2021.
//

import UIKit

final class InfoHeaderView: UIView {
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .csDarkBlack
        label.font = UIFont.boldSystemFont(ofSize: 15)
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

private extension InfoHeaderView {
    func setupUI() {
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.right.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview()
        }
        layoutIfNeeded()
    }
    
    private func sizeHeaderToFit() {
        setNeedsLayout()

        let height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = self.frame
        frame.size.height = height
        self.frame = frame
    }
}

extension InfoHeaderView {
    func prepare(text: String?) {
        headerLabel.text = text
        sizeHeaderToFit()
    }
}
