//
//  AppDelegate.swift
//  Ipsma3
//
//  Created by Buka Cakrawala on 8/2/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import Firebase
import Google






@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, FIRInviteDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //Use Firebase library to configure APIs
        FIRApp.configure()
        //initialize sign in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    
    
    //This method should call the handleURL method of the GIDSignIn instance
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String, annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    //For your app to run on iOS 8 and older, also implement the deprecated application:openURL:sourceApplication:annotation: method.
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        var options: [String: AnyObject] = [UIApplicationOpenURLOptionsSourceApplicationKey: sourceApplication!, UIApplicationOpenURLOptionsAnnotationKey: annotation]
        return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            print("Signed in!")
            
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
            
            UserData.sharedInstance.userId = userId
            UserData.sharedInstance.idToken = idToken
            UserData.sharedInstance.fullName = fullName
            UserData.sharedInstance.givenName = givenName
            UserData.sharedInstance.familyName = familyName
            UserData.sharedInstance.email = email
            
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewControllerWithIdentifier("RootNavigationController") 
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
        } else {
            print("\(error.localizedDescription)")
        }
        
    }
        
//    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
//        
//        if let dynamiclink = FIRDynamicLinks.dynamicLinks()?.dynamicLinkFromCustomSchemeURL(url) {
//            print("I am handling a link through the openURL method")
//            self.handleIncomingDynamicLink(dynamiclink)
//            return true
//        }
//        return false
//    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            //let linkHandled
            _ = FIRDynamicLinks.dynamicLinks()?.handleUniversalLink(incomingURL, completion: { [weak self](dynamiclink, error) in
                guard let strongSelf = self else {return}
                if let dynamiclink = dynamiclink, _ = dynamiclink.url {
                    strongSelf.handleIncomingDynamicLink(dynamiclink)
                }// else check for errors
                })
            return true
        }
        return false
    }
    
    func handleIncomingDynamicLink(dynamiclink: FIRDynamicLink) {
        if dynamiclink.matchConfidence == .Weak {
            print("I think your incoming link parameter is\(dynamiclink.url) but I'm not sure")
        } else {
            
            guard let pathComponents = dynamiclink.url?.pathComponents else {return}
            for nextPiece in pathComponents {
                //parsing going here
            }
            print("your incoming link parameter is \(dynamiclink.url)")
        }
    }

       
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

