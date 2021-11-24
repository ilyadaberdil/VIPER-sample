//
//  NotificationsViewController.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 18.11.2021.
//

import UIKit
import SnapKit
import MessageUI

final class NotificationsViewController: UIViewController {

    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(NotificationsTableViewCell.self)
        return tableView
    }()
        
    private lazy var statusPickerTextField: PickerTextField = {
        let field = PickerTextField()
        field.pickerDelegate = self
        field.dropShadow()
        return field
    }()
    
    private lazy var datePickerTextField: DatePickerTextField = {
        let field = DatePickerTextField()
        field.text = "Tarih"
        field.pickerDelegate = self
        field.dropShadow()
        return field
    }()
    
    private lazy var infoHeaderView: InfoHeaderView = {
        let headerView = InfoHeaderView()
        return headerView
    }()
    
    // MARK: - Properties
    var presenter: NotificationsPresenterProtocol!
    
    private var dataList: [NotificationCellViewModel] = .emptyValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bildirimler"
        view.backgroundColor = .csLightBackground
        setupUI()
        presenter.loadNotifications()
    }
}

// MARK: - UI
private extension NotificationsViewController {
    func setupUI() {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        
        stackView.addArrangedSubview(statusPickerTextField)
        stackView.addArrangedSubview(datePickerTextField)
        stackView.spacing = 10
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        view.layoutIfNeeded()
    }
}


// MARK: - NotificationsPresenterOutput
extension NotificationsViewController: NotificationsViewProtocol {
    func handleOutput(_ output: NotificationsPresenterOutput) {
        switch output {
        case .reloadData:
            tableView.reloadData()
        case .setData(let dataList):
            self.dataList = dataList
        case .setLoading(let isLoading):
            isLoading ? showLoading() : hideLoading()
        case .setDateFilterPlaceholder(let placeholder):
            datePickerTextField.text = placeholder
        case .setHeader(let headerText):
            if let text = headerText {
                infoHeaderView.prepare(text: text)
                tableView.tableHeaderView = infoHeaderView
            } else {
                tableView.tableHeaderView = nil
            }
        case .setStatusFilterPlaceholder(let placeholder):
            statusPickerTextField.text = placeholder
        case .showStatusFilters(let filters):
            statusPickerTextField.items = filters
            statusPickerTextField.pickerView.reloadAllComponents()
        }
    }
}

// MARK: - UITableViewDataSource
extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(NotificationsTableViewCell.self, indexPath: indexPath)
        cell.prepare(dataList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NotificationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        view.endEditing(true)
        presenter.selectNotification(at: indexPath.row)
    }
}

// MARK: - PickerTextFieldDelegate
extension NotificationsViewController: PickerTextFieldDelegate {
    func doneButtonTapped(pickerTextField: PickerTextField, selectedIndex: Int) {
        presenter.selectStatusFilter(at: selectedIndex)
    }
}

// MARK: - DatePickerTextFieldDelegate
extension NotificationsViewController: DatePickerTextFieldDelegate {
    func doneButtonTapped(datePickerTextField: DatePickerTextField, selectedDate: Date) {
        presenter.selectDateFilter(selectedDate)
    }
}
