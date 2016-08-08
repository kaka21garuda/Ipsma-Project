//
//  GoogleSignIn.swift
//  Ipsma3
//
//  Created by Buka Cakrawala on 8/7/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//
import UIKit
import Google



class GoogleSignIn: UIViewController, GIDSignInUIDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let signInButton = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        signInButton.center = view.center
        
        view.addSubview(signInButton)
        
        
    }
    
    
    
}
