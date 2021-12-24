//
//  ViewController.swift
//  Weather
//
//  Created by Дмитрий Цветков on 19.10.2021.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKCoreKit_Basics
import GoogleSignIn
class ViewController: UIViewController {
    @IBOutlet weak var pictureView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
    }
    @IBAction func Exit(_ sender: Any) { //Выход из аккаунта
        do{
            try Auth.auth().signOut()
            LoginManager().logOut()
            GIDSignIn.sharedInstance.signOut()
        }
        catch{
            print(error)
        }
    }
}
