//
//  Edits.swift
//  Weather
//
//  Created by Дмитрий Цветков on 21.12.2021.
//
import UIKit
import Foundation
class Edits: UIViewController{
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    var defaults = UserDefaults.standard //Переменная для хранения данных о Switch
    let onOffKey1="onOffKey1" //Ключ 1 switch
    let onOffKey2="onOffKey2" //Ключ 2 switch
    let onOffKey3="onOffKey3" //Ключ 3 switch
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        checkSwitchState1()
        checkSwitchState2()
        checkSwitchState3()
    }
    func checkSwitchState1(){
        if defaults.bool(forKey: onOffKey1){
            switch1.setOn(true, animated: false)
        }
        else {
            switch1.setOn(false, animated: false)
        }
    }
    func checkSwitchState2(){
        if defaults.bool(forKey: onOffKey2){
            switch2.setOn(true, animated: false)
        }
        else {
            switch2.setOn(false, animated: false)
        }
    }
    func checkSwitchState3(){
        if defaults.bool(forKey: onOffKey3){
            switch3.setOn(true, animated: false)
        }
        else {
            switch3.setOn(false, animated: false)
        }
    }
    @IBAction func switch1Action(_ sender: UISwitch) { //Действие первого switch
        if switch1.isOn {
            defaults.set(true, forKey: onOffKey1) // Сохраняем в defaults включенное положение кнопки 1
        } else {
            defaults.set(false, forKey: onOffKey1) // Сохраняем в defaults выключенное положение кнопки 1
        }

    }
    @IBAction func switch2Action(_ sender: UISwitch) {
        if switch2.isOn {
            defaults.set(true, forKey: onOffKey2)
        } else {
            defaults.set(false, forKey: onOffKey2)
        }

    }
    @IBAction func switch3Action(_ sender: UISwitch) {
        if switch3.isOn {
            defaults.set(true, forKey: onOffKey3)
        } else {
            defaults.set(false, forKey: onOffKey3)
        }
        
    }
}
