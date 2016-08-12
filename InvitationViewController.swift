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
    
    @IBAction func textFieldEditing(sender: UITextField) {
       
    }
    
    
    @IBAction func timeTextFieldEditing(sender: UITextField) {
    
    }
    
    @IBAction func inviteTapped(sender: AnyObject) {
        if let invite = FIRInvites.inviteDialog() {
            invite.setInviteDelegate(self)
            
            invite.setTitle("Ipsma Invites")
            invite.setMessage("Come to \(streetAdress!) for \(eventTextField.text!), \(dateTextField.text!) at \(timeTextField.text!) ")
            invite.open()
        }
    }
    
    
    func setupInputView() {
        
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        datePickerView = UIDatePicker(frame:
            CGRect(x: 0, y: 40, width: self.view.frame.width, height: 200))
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(InvitationViewController.doneButton(_:)), forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        dateTextField.inputView = inputView
        datePickerView.addTarget(self, action: #selector(InvitationViewController.handleDatePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        handleDatePicker(datePickerView) // Set the date on start.
    }
    
    func setupInputViewForTime() {
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        timePickerView = UIDatePicker(frame: CGRect(x: 0, y: 40, width: self.view.frame.width, height: 200))
        timePickerView.datePickerMode = UIDatePickerMode.Time
        inputView.addSubview(timePickerView)
        
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) //done button in inputview
        
        doneButton.addTarget(self, action: #selector(InvitationViewController.doneButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        timeTextField.inputView = inputView
        timePickerView.addTarget(self, action: #selector(InvitationViewController.handleTimePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        handleTimePicker(timePickerView)
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
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
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func handleTimePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = .ShortStyle
        timeTextField.text = timeFormatter.stringFromDate(sender.date)
    }
    
    func doneButton(sender: UIButton) {
        dateTextField.resignFirstResponder() // To resign the inputView on clicking done.
        timeTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
        
    func inviteFinishedWithInvitations(invitationIds: [AnyObject], error: NSError?) {
        if let error = error {
            print("Failed: " + error.localizedDescription)
        } else {
            print("Invitations sent")
        }
    }
    
}
