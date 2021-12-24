//
//  ViewController.swift
//  Weather
//
//  Created by Дмитрий Цветков on 19.10.2021.
//

import UIKit
import Firebase
class ViewController2: UIViewController{
    @IBOutlet weak var Log: UITextField! //Поле логина
    @IBOutlet weak var PasButton: UITextField! //Поле пароля
    @IBOutlet weak var EntryOutlet: UIButton! //Вход
    @IBOutlet weak var pictureView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.delegate = self
        PasButton.delegate = self
        self.view.addBackground()
    }
    func showAlert(){
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
        present(alert, animated:true,completion:nil)
    }

    @IBAction func Entry(_ sender: Any) {
        let login=Log.text!
        let password=PasButton.text!
        if (!login.isEmpty && !password.isEmpty){
            Auth.auth().signIn(withEmail: login, password: password){(result,error)in
                if error == nil{
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    self.showAlert()
                }
    }
}
    }
}
extension ViewController2: UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool { // То же самое при нажатии Enter
            let login=Log.text!
            let password=PasButton.text!
         if (!login.isEmpty && !password.isEmpty){
             Auth.auth().signIn(withEmail: login, password: password){(result,error)in
                 if error == nil{
                    self.dismiss(animated: true, completion: nil)
                 }
                 else{
                     self.showAlert()
                 }
             }
    }
         return true
        }
}
