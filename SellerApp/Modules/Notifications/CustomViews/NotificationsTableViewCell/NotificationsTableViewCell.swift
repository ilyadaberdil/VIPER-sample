//
//  NotificationsTableViewCell.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import UIKit
import SnapKit

final class NotificationsTableViewCell: UITableViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .csDarkBlack
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .csDarkGray
        label.numberOfLines = .zero
        return label
    }()
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .csDarkGray
        return label
    }()
    
    private let badgeView: InfoBadgeView = {
       let badgeView = InfoBadgeView()
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        return badgeView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - UI
private extension NotificationsTableViewCell {
    
    func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        containerView.dropShadow()
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        containerView.addSubview(badgeView)
        badgeView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
        }
        
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
            make.left.greaterThanOrEqualTo(badgeView.snp.right)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(badgeView.snp.bottom).offset(10)
        }
        
        containerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        layoutIfNeeded()
    }
}

// MARK: - Prepare
extension NotificationsTableViewCell {
    func prepare(_ data: NotificationCellViewModel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        dateLabel.text = data.date
        badgeView.prepare(data.infoBadge)
    }
}
