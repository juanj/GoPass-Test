//
//  SignUpViewController.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import UIKit

class SignUpViewController: BaseViewController {
    @IBOutlet weak var documentTypeTextField: PaddedTextField!
    @IBOutlet weak var documentNumberTextField: PaddedTextField!
    @IBOutlet weak var nameTextField: PaddedTextField!
    @IBOutlet weak var lastNameTextField: PaddedTextField!
    @IBOutlet weak var emailTextField: PaddedTextField!
    @IBOutlet weak var countryCodeTextField: PaddedTextField!
    @IBOutlet weak var phoneNumberTextField: PaddedTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var documentType: DocumentType?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureScrollView()
        configureTapGesture()
        configureTypePicker()
        configureTextFieldsDelegate()
    }

    private func configureScrollView() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateInsets(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateInsets(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    private func configureTypePicker() {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        documentTypeTextField.inputView = picker
        documentTypeTextField.tintColor = .clear
    }

    private func configureTextFieldsDelegate() {
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        countryCodeTextField.delegate = self
        phoneNumberTextField.delegate = self
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc func updateInsets(_ notification: Notification) {
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset.bottom = 0
            return
        }
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset.bottom = frame.height
    }
}

extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return OptionsValues.shared.documentTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return OptionsValues.shared.documentTypes[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        documentType = OptionsValues.shared.documentTypes[row]
        documentTypeTextField.text = documentType?.abreviated()
        documentNumberTextField.becomeFirstResponder()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            countryCodeTextField.becomeFirstResponder()
        case countryCodeTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            view.endEditing(true)
        default:
            break
        }
        return true
    }
}
