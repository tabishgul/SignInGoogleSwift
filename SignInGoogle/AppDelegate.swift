//
//  AppDelegate.swift
//  SignInGoogle
//
//  Created by Tabish Gul on 09/07/2019.
//  Copyright © 2019 Tabish Gul. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "972538328781-er740krqci5i3ki536l9dv0a8ols5ei1.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            print(userId as Any)
            let idToken = user.authentication.idToken // Safe to send to the server
            print(idToken as Any)
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            print(givenName as Any)
            let familyName = user.profile.familyName
            print(familyName as Any)
            let email = user.profile.email
            
            var userData = [String:String?]()
            guard let fullName = fullName, let email = email else {
                return
            }
            userData = ["myName": fullName, "mailAddress": email]
            NotificationCenter.default.post(name: Notification.Name(rawValue: fullnameNotification), object: nil, userInfo: userData as [AnyHashable : Any])
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        print("User has disconnected")
    }
}

