//
//  PickerTextField.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 19.11.2021.
//

import UIKit

protocol PickerTextFieldDelegate: AnyObject {
    func didSelectRow(pickerTextField: PickerTextField, at index: Int)
    func doneButtonTapped(pickerTextField: PickerTextField, selectedIndex: Int)
}

extension PickerTextFieldDelegate {
    func didSelectRow(pickerTextField: PickerTextField, at index: Int) { }
}

final class PickerTextField: UITextField {
    
    private(set) lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 32)
    
    var items: [String] = .emptyValue {
        didSet {
            pickerView.reloadComponent(.zero)
        }
    }
    
    private var selectedIndex: Int = .zero

    weak var pickerDelegate: PickerTextFieldDelegate?
    
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
private extension PickerTextField {
    
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
private extension PickerTextField {
    @objc func toolbarApplyButtonTapped() {
        selectedIndex = pickerView.selectedRow(inComponent: .zero)
        pickerDelegate?.doneButtonTapped(pickerTextField: self, selectedIndex: selectedIndex)
        resignFirstResponder()
    }
    
    @objc func editingDidEnd(_ textField: PickerTextField) {
        pickerView.selectRow(selectedIndex, inComponent: .zero, animated: false)
    }
}

// MARK: - Override Methods
extension PickerTextField {
    
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
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
}

// MARK: - UIPickerViewDataSource
extension PickerTextField: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row < items.count else {
            return nil
        }
        return items[row]
    }
}

// MARK: - UIPickerViewDelegate
extension PickerTextField: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerDelegate?.didSelectRow(pickerTextField: self, at: row)
    }
}
