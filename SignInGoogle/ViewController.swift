//
//  ViewController.swift
//  SignInGoogle
//
//  Created by Tabish Gul on 09/07/2019.
//  Copyright © 2019 Tabish Gul. All rights reserved.
//

import UIKit
import GoogleSignIn

let fullnameNotification = "Vdevelopers.fullname"


class ViewController: UIViewController, GIDSignInUIDelegate{
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    
    let name = Notification.Name(rawValue: fullnameNotification)
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateLabels(notification:)), name: name, object: nil)
    }
    
    @objc func updateLabels(notification: NSNotification){
        //value in userInfo is of type Any, need to be type cast when used.
        let receavedName = notification.userInfo?["myName"]
        let receavedEmail = notification.userInfo?["mailAddress"]
        fullName.text = receavedName as? String
        emailAddress.text = receavedEmail as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.signInSilently()
        
        let gSignIn = GIDSignInButton()
        gSignIn.center = view.center
        view.addSubview(gSignIn)
        
        self.createObservers()
    }

    @IBAction func TapSignOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        fullName.text = ""
        emailAddress.text = ""
    }
}

