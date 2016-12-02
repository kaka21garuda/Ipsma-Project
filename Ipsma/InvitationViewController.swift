//
//  InvitationViewController.swift
//  Ipsma
//
//  Created by Buka Cakrawala on 11/30/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import Foundation
import UIKit
import FirebaseInvites

class InvitationViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, FIRInviteDelegate {
    
    var datePickerView: UIDatePicker! = nil
    var timePickerView: UIDatePicker! = nil
    
    var streetAdress: String?
    
    
    @IBOutlet weak var eventTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!

    @IBOutlet weak var timeTextField: UITextField!

    @IBAction func inviteButton(_ sender: Any) {
        if let invite = FIRInvites.inviteDialog() {
            invite.setInviteDelegate(self)
            
            invite.setTitle("Ipsma Invites")
            invite.setMessage("come to \(streetAdress!) for \(eventTextField.text!), \(dateTextField.text!) at \(timeTextField.text!)")
            invite.open()
        }
    }
    
    func setupInputView() {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        datePickerView = UIDatePicker(frame: CGRect(x: 0, y: 40, width: self.view.frame.width, height: 200))
        datePickerView.datePickerMode = UIDatePickerMode.date
        inputView.addSubview(datePickerView) //added date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.gray, for: .highlighted)
        inputView.addSubview(doneButton) //added done button to UIView
        
        doneButton.addTarget(self, action: #selector(InvitationViewController.doneButton(_:)), for: .touchUpInside)
        
        dateTextField.inputView = inputView
        datePickerView.addTarget(self, action: #selector(InvitationViewController.handleDatePicker), for: .valueChanged)
        
        handleDatePicker(datePickerView)
        
        
    }
    
    func setupInputViewForTime() {
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        timePickerView = UIDatePicker(frame: CGRect(x: 0, y: 40, width: self.view.frame.width, height: 200))
        timePickerView.datePickerMode = UIDatePickerMode.time
        inputView.addSubview(timePickerView)
        
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.gray, for: .highlighted)
        
        inputView.addSubview(doneButton)
        
        doneButton.addTarget(self, action: #selector(InvitationViewController.doneButton(_:)), for: .valueChanged)
        
        handleTimePicker(timePickerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputView()
        setupInputViewForTime()
        
        eventTextField.delegate = self
        dateTextField.delegate = self
        timeTextField.delegate = self
    }
    
    func handleDatePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    func handleTimePicker(_ sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeTextField.text = timeFormatter.string(from: sender.date)
    }
    
    func doneButton(_ sender: UIButton) {
        dateTextField.resignFirstResponder()
        timeTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func inviteFinished(withInvitations invitationIds: [Any], error: Error?) {
        if let error = error {
            print("FAILED: \(error.localizedDescription)")
        } else {
            print("Invitation sent")
        }
    }

}

