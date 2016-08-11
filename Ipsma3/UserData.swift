//
//  UserData.swift
//  Ipsma3
//
//  Created by Buka Cakrawala on 8/8/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import Firebase
import Google


class UserData {
    static let sharedInstance = UserData()
    
    var userId: String = ""                 // For client-side use only!
    var idToken: String = "" // Safe to send to the server
    var fullName: String = ""
    var givenName: String = ""
    var familyName: String = ""
    var email: String = ""
    
    private init() {
        
    }
    
}