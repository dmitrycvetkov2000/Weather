//
//  ViewController3.swift
//  Weather
//
//  Created by Дмитрий Цветков on 19.10.2021.
//

import UIKit
import Firebase
class ViewController3: UIViewController {
    @IBOutlet weak var Name: UITextField! //Поле имени
    @IBOutlet weak var Email: UITextField! //Поле почты
    @IBOutlet weak var Password: UITextField! //Поле пароля
    @IBOutlet weak var RegistrOutlet: UIButton!
    @IBOutlet weak var LabelQuestion: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Name.delegate = self
        Email.delegate = self
        Password.delegate = self
        self.view.addBackground()
    }
    func showAlert(){
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
        present(alert, animated:true,completion:nil)
    }
    @IBAction func Vxod(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func RegistrAction(_ sender: UIButton) { //Действие при нажитии на кнопку зарегистрироваться
        let nameField=Name.text!
        let email=Email.text!
        let password=Password.text!
     if (!nameField.isEmpty && !email.isEmpty && !password.isEmpty){
         Auth.auth().createUser(withEmail: email, password: password) { (result, error)in
             if error == nil{
                 if let result=result{
                     print(result.user.uid)
                     let ref = Database.database().reference().child("users")
                     ref.child(result.user.uid).updateChildValues(["name":nameField, "email":email])
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                 }
             }
         }
         }else{
         self.showAlert()
     }
    }
}
extension ViewController3: UITextFieldDelegate{
       func textFieldShouldReturn(_ textField: UITextField) -> Bool { //То же самое
           let nameField=Name.text!
           let email=Email.text!
           let password=Password.text!
        if (!nameField.isEmpty && !email.isEmpty && !password.isEmpty){
            Auth.auth().createUser(withEmail: email, password: password) { (result, error)in
                if error == nil{
                    if let result=result{
                        print(result.user.uid)
                        let ref = Database.database().reference().child("users")
                        ref.child(result.user.uid).updateChildValues(["name":nameField, "email":email])
                        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    }
                }
            }
            }else{
            self.showAlert()
        }
           return true
}
}
