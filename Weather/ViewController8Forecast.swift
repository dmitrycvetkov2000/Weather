//
//  ViewController8Forecast.swift
//  Weather
//
//  Created by Дмитрий Цветков on 13.11.2021.
//

import UIKit
import Foundation

class ViewController8Forecast: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let defaults = UserDefaults.standard
    func num()->String{
        var num = ""
        if self.defaults.value(forKey: "onOffKey3") != nil{
            let switchON: Bool = self.defaults.value(forKey: "onOffKey3")  as! Bool
            if switchON == true{
                num = "м/с"
                        }
                        else if switchON == false{
                            num = "км/ч"
                        }
        }
        return num
    }
var days: [String] = []
var temps: [String] = []
var windSpeeds: [Int] = []
var tempsss7:[Int] = []
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var pictureView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
}

    //MARK: - таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{ //Число строк
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //Заполняем ячейки
        var cellToReturn = UITableViewCell()
        if tableView == self.tableView1{
            let cell = tableView1.dequeueReusableCell(withIdentifier: "CellIndenti", for: indexPath)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.text = days[indexPath.row]
            //cell.backgroundColor = .clear
            //cell.textLabel?.textColor = .systemIndigo
            cellToReturn = cell
        }
        else if tableView == self.tableView2{
            let cell = tableView2.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.text = temps[indexPath.row]
            //cell.textLabel?.textColor = .systemIndigo
            //cell.backgroundColor = .clear
            cellToReturn = cell
        }
        return cellToReturn
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let myAction = UIContextualAction(style: .normal, title: nil) { _,_,_ in
            self.personfeel(num1: self.tempsss7[indexPath.row],num2: self.windSpeeds[indexPath.row]) //Вызываем функцию, которая показывает как одеться
        }
        return UISwipeActionsConfiguration(actions: [myAction])
    }
    
    func personfeel(num1: Int, num2: Int){ //num1: tempsss7
        if num1 >= 0 && num1 < 10 && num2 >= 8{
            func showAlert(){
                let alert = UIAlertController(title: "Прохладно", message: "Не забудьте надеть джемпер и куртку/олимпийку, скорость ветра \(num2)\(num()), поэтому наденьте шапку", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
                present(alert, animated:true,completion:nil)
            }
            showAlert()
        }
        if num1 >= 0 && num1 < 10 && num2 < 8{
            func showAlert(){
                let alert = UIAlertController(title: "Прохладно", message: "Не забудьте надеть легкий джемпер и куртку/олимпийку, скорость ветра \(num2)\(num())", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
                present(alert, animated:true,completion:nil)
            }
            showAlert()
        }
        if num1 >= 10 && num1 < 20 && num2 >= 8{
            func showAlert(){
                let alert = UIAlertController(title: "Прохладно", message: "Рекомендуем надеть тонкую водолазку и легкую ветровку, скорость ветра \(num2)\(num())", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
                present(alert, animated:true,completion:nil)
            }
            showAlert()
        }
        if num1 >= 10 && num1 < 20 && num2 < 8{
            func showAlert(){
                let alert = UIAlertController(title: "Достаточно тепло", message: "Рекомендуем надеть футболку и толстовку/олимпийку, скорость ветра \(num2)\(num())", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
                present(alert, animated:true,completion:nil)
            }
            showAlert()
        }
        if num1 >= 20{
            func showAlert(){
                let alert = UIAlertController(title: "Жарко", message: "Рекомендуем надеть футболку, скорость ветра \(num2)\(num())", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
                present(alert, animated:true,completion:nil)
            }
            showAlert()
        }
        if num1 < 0 && num1 >= -10 && num2 < 8{
            func showAlert(){
                let alert = UIAlertController(title: "Заморозки", message: "Рекомендуем надеть теплый свитер и куртку с легкой шапкой, скорость ветра \(num2)\(num())", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
                present(alert, animated:true,completion:nil)
            }
            showAlert()
        }
        if num1 < 0 && num1 >= -10 && num2 >= 8{
            func showAlert(){
                let alert = UIAlertController(title: "Заморозки", message: "Рекомендуем надеть теплый свитер и куртку с легкой шапкой и шарфом, скорость ветра \(num2)\(num())", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
                present(alert, animated:true,completion:nil)
            }
            showAlert()
        }
        if num1 < -10 && num1 >= -20{
            func showAlert(){
                let alert = UIAlertController(title: "Холодно", message: "Рекомендуем надеть теплый свитер и куртку с теплой шапкой и шарфом, скорость ветра \(num2)\(num())", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
                present(alert, animated:true,completion:nil)
            }
            showAlert()
        }
        if num1 < -20{
            func showAlert(){
                let alert = UIAlertController(title: "Очень холодно", message: "Рекомендуем надеть два теплых свитера и куртку с теплой шапкой и шарфом, скорость ветра \(num2)\(num())", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default, handler:nil))
                present(alert, animated:true,completion:nil)
            }
            showAlert()
        }
    }
}



