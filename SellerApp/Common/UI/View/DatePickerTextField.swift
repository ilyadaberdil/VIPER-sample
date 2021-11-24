//
//  PickerTextField.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 19.11.2021.
//

import UIKit

protocol DatePickerTextFieldDelegate: AnyObject {
    func doneButtonTapped(datePickerTextField: DatePickerTextField, selectedDate: Date)
}

final class DatePickerTextField: UITextField {
    
    private(set) lazy var pickerView: UIDatePicker = {
        let pickerView = UIDatePicker(frame: .init(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 300)))
        pickerView.datePickerMode = .date
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.4, *) {
            pickerView.preferredDatePickerStyle = .wheels
        }
        return pickerView
    }()
    
    private let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 32)
    
    var items: [String] = .emptyValue {
        didSet {
            pickerView.reloadInputViews()
        }
    }
    
    private var selectedDate: Date?
    
    weak var pickerDelegate: DatePickerTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - UI
private extension DatePickerTextField {
    
    func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 5.0
        tintColor = .clear
        rightViewMode = .always
        textColor = .csPlaceholderColor
        font = UIFont.systemFont(ofSize: 13, weight: .medium)
        inputView = pickerView
        
        appendDownArrowAsRightItem()
        setupToolbar()
        addTarget(self, action: #selector(editingDidEnd(_:)), for: .editingDidEnd)
    }
    
    func setupToolbar() {
        let toolBar = getPickerToolbar(applyAction: #selector(toolbarApplyButtonTapped))
        inputAccessoryView = toolBar
    }
}

// MARK: - Actions
private extension DatePickerTextField {
    @objc func toolbarApplyButtonTapped() {
        selectedDate = pickerView.date
        pickerDelegate?.doneButtonTapped(datePickerTextField: self, selectedDate: pickerView.date)
        resignFirstResponder()
    }
    
    @objc func editingDidEnd(_ textField: DatePickerTextField) {
        pickerView.setDate(selectedDate ?? Date(), animated: false)
    }
}

// MARK: - Override Methods
extension DatePickerTextField {
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
