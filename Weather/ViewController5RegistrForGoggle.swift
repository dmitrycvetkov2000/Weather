//
//  ViewController5RegistrForGoggle.swift
//  Weather
//
//  Created by Дмитрий Цветков on 27.10.2021.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKCoreKit_Basics
import Firebase
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
class ViewController5RegistrForGoggle: UIViewController {
    @IBOutlet weak var pictureView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
    }
    @IBAction func FacebookAction(_ sender: UIButton) { //Регистрация с помощью Facebook
        let login = LoginManager()
        login.logIn(permissions: ["email","public_profile"], from: self) { (result, error) in
            if result!.isCancelled{
                print("Is cancelled")
            }
            else{
                if error == nil{
                    GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: AccessToken.current?.tokenString, version: nil, httpMethod: HTTPMethod(rawValue: "GET")).start { (nil, result, error) in
                        if error==nil{
                            print(result as Any)
                            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                            Auth.auth().signIn(with: credential) { (result, error) in
                                        if error == nil{
                                            print(result?.user.uid as Any)
                                            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                                        }else{
                                            print(error as Any)
                                        }
                                    }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func GoogleAction(_ sender: UIButton) { //Регистрация с помощью Google
        let signInConfig = GIDConfiguration.init(clientID: "520639171957-02ltvger1ik2j60lvpq1rrhck4p9mm3p.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { (user, error) in
            if error == nil {
                let authentication = user?.authentication
                let idToken = authentication?.idToken
                let credential = GoogleAuthProvider.credential(withIDToken: idToken!, accessToken: authentication!.accessToken)
                Auth.auth().signIn(with: credential) { (result, error) in
                            if error == nil{
                                print(result?.user.uid as Any)
                                //self.dismiss(animated: true, completion: nil)
                                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                            }else{
                                print(error as Any)
                            }
                        }
            }
            
          }
    }
}
