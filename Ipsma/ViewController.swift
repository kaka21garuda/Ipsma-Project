//
//  ViewController.swift
//  Ipsma
//
//  Created by Buka Cakrawala on 11/16/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func LogInButton(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                self.performSegue(withIdentifier: "segueToLocationSearch", sender: nil)
            }
        })
    }
    
    
    @IBAction func singUpButton(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                self.performSegue(withIdentifier: "segueToLocationSearch", sender: nil)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        passwordTextField.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

