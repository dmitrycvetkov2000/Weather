//
//  ViewController4RememberParol.swift
//  Weather
//
//  Created by Дмитрий Цветков on 24.10.2021.
//

import UIKit
import FirebaseAuth
class ViewController4RememberParol: UIViewController {
    @IBOutlet weak var WriteEmail: UITextField!
    @IBOutlet weak var pictureView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
    }
    func showAlert(){
        let alert = UIAlertController(title: "Ошибка", message: "Заполните поле", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
        present(alert, animated:true,completion:nil)
    }
    func showAlert2(){
        let alert = UIAlertController(title: "Ошибка", message: "Введен некорректный email/Не существует", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
        present(alert, animated:true,completion:nil)
    }
    func showOk(){
        let alert = UIAlertController(title: "Успешно", message: "Ссылка на восстановление отправлена", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
        present(alert, animated:true,completion:nil)
    }
    @IBAction func RememberPasAction(_ sender: UIButton) {
        let email = WriteEmail.text!
        if (!email.isEmpty){
            Auth.auth().sendPasswordReset(withEmail: email) {(error) in
                if error == nil{
                    self.showOk()
                }
                else {
                    self.showAlert2()
                }
            }
        }
        else {
            self.showAlert()
        }
        
    }
    @IBAction func ExitButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
