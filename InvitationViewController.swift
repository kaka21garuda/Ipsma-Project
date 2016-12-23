//
//  InvitationViewController.swift
//  Ipsma3
//
//  Created by Buka Cakrawala on 8/9/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInvites
import Google


class InvitationViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, FIRInviteDelegate {

    var datePickerView: UIDatePicker! = nil
    var timePickerView: UIDatePicker! = nil
    
    var streetAdress: String!
    
    //TIME TEXT FIELD
    @IBOutlet weak var timeTextField: UITextField!
    //EVENT TEXT FIELD
    @IBOutlet weak var eventTextField: UITextField!
    //DATE TEXT FIELD
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
       
    }
    
    
    @IBAction func timeTextFieldEditing(_ sender: UITextField) {
    
    }
    
    @IBAction func inviteTapped(_ sender: AnyObject) {
        if let invite = FIRInvites.inviteDialog() {
            invite.setInviteDelegate(self)
            
            invite.setTitle("Ipsma Invites")
            invite.setMessage("Come to \(streetAdress!) for \(eventTextField.text!), \(dateTextField.text!) at \(timeTextField.text!) ")
            invite.open()
        }
    }
    
    
    func setupInputView() {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        
        datePickerView = UIDatePicker(frame:
            CGRect(x: 0, y: 40, width: self.view.frame.width, height: 200))
        datePickerView.datePickerMode = UIDatePickerMode.date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(InvitationViewController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        
        dateTextField.inputView = inputView
        datePickerView.addTarget(self, action: #selector(InvitationViewController.handleDatePicker(_:)), for: UIControlEvents.valueChanged)
        
        handleDatePicker(datePickerView) // Set the date on start.
    }
    
    func setupInputViewForTime() {
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        timePickerView = UIDatePicker(frame: CGRect(x: 0, y: 40, width: self.view.frame.width, height: 200))
        timePickerView.datePickerMode = UIDatePickerMode.time
        inputView.addSubview(timePickerView)
        
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) //done button in inputview
        
        doneButton.addTarget(self, action: #selector(InvitationViewController.doneButton(_:)), for: UIControlEvents.touchUpInside)
        
        timeTextField.inputView = inputView
        timePickerView.addTarget(self, action: #selector(InvitationViewController.handleTimePicker(_:)), for: UIControlEvents.valueChanged)
        
        handleTimePicker(timePickerView)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("----+++++------")
//        if let streetAdress = streetAdress {
//            print("| Street address: \(streetAdress!) |")
//        }
        print("Street Addess \(streetAdress!)")
        print("------++++-----")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputView()
        setupInputViewForTime()
        // Do any additional setup after loading the view.
        
        eventTextField.delegate = self
        dateTextField.delegate = self
        timeTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        dateTextField.resignFirstResponder() // To resign the inputView on clicking done.
        timeTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
        
    func inviteFinished(withInvitations invitationIds: [AnyObject], error: NSError?) {
        if let error = error {
            print("Failed: " + error.localizedDescription)
        } else {
            print("Invitations sent")
        }
    }
    
}
