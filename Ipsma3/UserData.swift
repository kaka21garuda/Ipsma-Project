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
    
    var userId: String = ""                
    var idToken: String = ""
    var fullName: String = ""
    var givenName: String = ""
    var familyName: String = ""
    var email: String = ""
    
    fileprivate init() {
        
    }
    
}
